<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\PalletTransferCollection;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;
use App\TransporterAdjusment;
use App\DeletedItem;
use App\PoolPallet;
use App\Vehicle;
use App\Driver;
use App\Transporter;
use App\Alltransaction;
use DB;

class TransporterAdjusmentController extends Controller
{
    public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        if($pool_pallet=='pooldli' && $role<5){
        $transporterAdjusment = DB::table('transporter_adjusment as a')
            ->join('pool_pallet as b', 'a.pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('users as c', 'a.reporter_user_id', '=', 'c.id')
            ->join('transporter as d', 'a.transporter_id', '=', 'd.transporter_id')
            ->select('a.*', 'b.pool_name','c.name', 'd.transporter_name')
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $transporterAdjusment = DB::table('transporter_adjusment as a')
            ->join('pool_pallet as b', 'a.pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('users as c', 'a.reporter_user_id', '=', 'c.id')
            ->join('transporter as d', 'a.transporter_id', '=', 'd.transporter_id')
            ->select('a.*', 'b.pool_name','c.name', 'd.transporter_name')
            ->where('b.pool_pallet_id',$pool_pallet)
            ->orWhere('a.transporter_id',$transporter)
            ->paginate(1000000)
            ->toArray();
        }
        return $transporterAdjusment;
    }

    public function show($transporter_adjusment_id)
    {
        $transporterAdjusment = TransporterAdjusment::find($transporter_adjusment_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $transporterAdjusment]);
    }

    public function store(Request $request)
    {
        $now = Carbon::now()->toDateTimeString();
        $transporter_id = $request->transporter_id;
        $transporter = Transporter::find($transporter_id);
        $pool_pallet_id = $request->pool_pallet_id;
        $pool_pallet = PoolPallet::find($pool_pallet_id);
        $is_from_pool = $request->is_from_pool;

        if($is_from_pool == 0){
            $good_pallet_pool = $pool_pallet->good_pallet;
            $tbr_pallet_pool = $pool_pallet->tbr_pallet;
            $this->validate($request, [
                'good_pallet' => 'required|integer|gt:-1|lte:'.$good_pallet_pool,
                'tbr_pallet' => 'required|integer|gt:-1|lte:'.$tbr_pallet_pool,
                'is_from_pool' => 'required',
                'reason' => 'required',
            ]);
        }
        else{
            $good_pallet_transporter = $transporter->good_pallet;
            $tbr_pallet_transporter = $transporter->tbr_pallet;
            $this->validate($request, [
                'good_pallet' => 'required|integer|gt:-1|lte:'.$good_pallet_transporter,
                'tbr_pallet' => 'required|integer|gt:-1|lte:'.$tbr_pallet_transporter,
                'is_from_pool' => 'required',
                'reason' => 'required',
            ]);
        }

        DB::beginTransaction();
        try{
            $reporter = Auth::user()->id;
            $transporterAdjusment = TransporterAdjusment::create([
                'pool_pallet_id' => $request->pool_pallet_id,
                'transporter_id' => $request->transporter_id,
                'reporter_user_id' => $reporter,
                'good_pallet' => $request->good_pallet,
                'tbr_pallet' => $request->tbr_pallet,
                'ber_pallet' => $request->ber_pallet,
                'missing_pallet' => $request->missing_pallet,
                'is_from_pool' => $request->is_from_pool,
                'reason' => $request->reason,
                'note' => $request->note,
                // 'created_at' => $now,
                // 'updated_at' => $now,
            ]);

            // Membuat log All Transaction
            if($is_from_pool == 0){
                $transaction = "Adjustment From Pool Pallet to Transporter";
            }
            else{
                $transaction = "Adjustment From Transporter to Pool Pallet";
            }
            $reporterName = Auth::user()->name;
            $pool_name = $pool_pallet->pool_name;
            $transporter_name = $transporter->transporter_name;
            $alltransaction = Alltransaction::create([
                'reference_transporter_adjusment_id' => $transporterAdjusment->transporter_adjusment_id,
                'transaction' => $transaction,
                'sender/reporter' => $reporterName,
                'status' => 'ADJUST',
                'pool_pallet' => $pool_pallet->pool_name,
                'transporter' => $transporter->transporter_name,
                'good_pallet' => $transporterAdjusment->good_pallet,
                'tbr_pallet' => $transporterAdjusment->tbr_pallet,
                'ber_pallet' => $transporterAdjusment->ber_pallet,
                'missing_pallet' => $transporterAdjusment->missing_pallet,
                'reason' => $transporterAdjusment->reason,
                'note' => $transporterAdjusment->note,
                // 'created_at' => $now,
                // 'updated_at' => $now,
            ]);

            if($is_from_pool == 0){
                $inventory_pool = PoolPallet::find($pool_pallet_id);
                $inventory_pool->good_pallet = (($inventory_pool->good_pallet)-($request->good_pallet));
                $inventory_pool->tbr_pallet = (($inventory_pool->tbr_pallet)-($request->tbr_pallet));
                $inventory_pool->ber_pallet = (($inventory_pool->ber_pallet)-($request->ber_pallet));
                $inventory_pool->missing_pallet = (($inventory_pool->missing_pallet)-($request->missing_pallet));
                $inventory_pool->save();

                $inventory_transporter = Transporter::find($transporter_id);
                $inventory_transporter->good_pallet = (($inventory_transporter->good_pallet)+($request->good_pallet));
                $inventory_transporter->tbr_pallet = (($inventory_transporter->tbr_pallet)+($request->tbr_pallet));
                $inventory_transporter->ber_pallet = (($inventory_transporter->ber_pallet)+($request->ber_pallet));
                $inventory_transporter->missing_pallet = (($inventory_transporter->missing_pallet)+($request->missing_pallet));
                $inventory_transporter->save();
            }
            else{
                $inventory_pool = PoolPallet::find($pool_pallet_id);
                $inventory_pool->good_pallet = (($inventory_pool->good_pallet)+($request->good_pallet));
                $inventory_pool->tbr_pallet = (($inventory_pool->tbr_pallet)+($request->tbr_pallet));
                $inventory_pool->ber_pallet = (($inventory_pool->ber_pallet)+($request->ber_pallet));
                $inventory_pool->missing_pallet = (($inventory_pool->missing_pallet)+($request->missing_pallet));
                $inventory_pool->save();

                $inventory_transporter = Transporter::find($transporter_id);
                $inventory_transporter->good_pallet = (($inventory_transporter->good_pallet)-($request->good_pallet));
                $inventory_transporter->tbr_pallet = (($inventory_transporter->tbr_pallet)-($request->tbr_pallet));
                $inventory_transporter->ber_pallet = (($inventory_transporter->ber_pallet)-($request->ber_pallet));
                $inventory_transporter->missing_pallet = (($inventory_transporter->missing_pallet)-($request->missing_pallet));
                $inventory_transporter->save();
            }


            DB::commit();
            return response()->json(['status' => 'success'], 200);
        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Transporter Adjusment Record'], 422);
            }
    }

}
