<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Damagedpallet;
use App\PoolPallet;
use App\DeletedItem;
use App\Alltransaction;
use DB;

class FilledtoGoodPallet extends Controller
{
    public function index()
    {
        //     $damagedpallet = DB::table('damaged_pallet as a')
        //     ->join('pool_pallet as b', 'a.pool_pallet_id', '=', 'b.pool_pallet_id')
        //     ->join('users as c', 'a.reporter_user_id', '=', 'c.id')
        //     ->select('a.*', 'b.pool_name', 'c.name')
        //     ->paginate(10000000)
        //     ->toArray();
        //  return $damagedpallet;
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        if($pool_pallet=='pooldli' && $role<5){
            $damagedpallet = DB::table('damaged_pallet as a')
            ->orderBy('created_at', 'DESC')
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->leftJoin('pool_pallet as c', 'a.pool_pallet_id', '=', 'c.pool_pallet_id')
            ->leftJoin('transporter as d', 'a.transporter_id', '=', 'd.transporter_id')
            ->leftJoin('sjp_status as e', 'a.reference_sjp_status_id', '=', 'e.sjp_status_id')
            ->select('a.*', 'b.name',
                    'c.pool_name','d.transporter_name', 'e.sjps_number')
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $damagedpallet = DB::table('damaged_pallet as a')
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->leftJoin('pool_pallet as c', 'a.pool_pallet_id', '=', 'c.pool_pallet_id')
            ->leftJoin('transporter as d', 'a.transporter_id', '=', 'd.transporter_id')
            ->leftJoin('sjp_status as e', 'a.reference_sjp_status_id', '=', 'e.sjp_status_id')
            ->select('a.*', 'b.name',
                    'c.pool_name','d.transporter_name', 'e.sjps_number')
            ->where('a.pool_pallet_id',$pool_pallet)
            ->orWhere('a.transporter_id', $transporter)
            ->paginate(10000000)
            ->toArray();
        }
        return $damagedpallet;
        // return response()->json(Sjp::all()->toArray());
    }

    public function show($damaged_pallet_id)
    {
        $damagedpallet = Damagedpallet::find($damaged_pallet_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $damagedpallet]);
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'good_pallet' => 'required|gt:0',
        ]);

        $pool_pallet_id = auth()->user()->reference_pool_pallet_id;
        $transporter_id = auth()->user()->reference_transporter_id;
        $pallet = PoolPallet::find($pool_pallet_id); //jgn lupa add model poolpallet
        $qty_pool = $pallet->filled_pallet;
        $pallet_qty = $request->good_pallet;


        if($pallet_qty>$qty_pool)
        {
            return response()->json(['error' => 'Pallet Melebihi Quantity yang ada'], 404);
        }
        else {
            DB::beginTransaction();
            try{
                $filledToGood = Damagedpallet::create([
                    'reporter_user_id' => auth()->user()->id,
                    'pool_pallet_id' => auth()->user()->reference_pool_pallet_id,
                    'transporter_id' => auth()->user()->reference_transporter_id,
                    'tbr_pallet' => $request->tbr_pallet,
                    'note' => $request->note,
                ]);
                    if($pool_pallet_id!=null){
                        $InventoryPool = PoolPallet::find($pool_pallet_id);
                        $InventoryPool->good_pallet = (($InventoryPool->good_pallet)-($request->tbr_pallet));
                        $InventoryPool->tbr_pallet = (($InventoryPool->tbr_pallet)+($request->tbr_pallet));
                        $InventoryPool->save();
                    }
                    if($transporter_id!=null){
                        $InventoryTrans = Transporter::find($transporter_id);
                        $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($request->tbr_pallet));
                        $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)+($request->tbr_pallet));
                        $InventoryTrans->save();
                    }

                    // Membuat log All Transaction
                    if($pool_pallet_id!=null){
                        $reporter = Auth::user()->name;
                        $pool_pallet_id = Auth::user()->reference_pool_pallet_id;
                        $transporter_id = Auth::user()->reference_transporter_id;
                        $damagedreportpool = PoolPallet::find($pool_pallet_id);
                        // $bermissingreporttrans = Transporter::find($transporter_id);
                        $alltransaction = Alltransaction::create([
                            'reference_damaged_pallet_id' => $damagedpallet->damaged_pallet_id,
                            'transaction' => 'Damaged Pallet Report',
                            'sender/reporter' => $reporter,
                            'status' => 'REPORTED',
                            'pool_pallet' => $damagedreportpool->pool_name,
                            // 'transporter' => $bermissingreporttrans->transporter_name,
                            'tbr_pallet' => $damagedpallet->tbr_pallet,
                            'note' => $request->note,
                        ]);
                    }
                    if($transporter_id!=null){
                        $reporter = Auth::user()->name;
                        $pool_pallet_id = Auth::user()->reference_pool_pallet_id;
                        $transporter_id = Auth::user()->reference_transporter_id;
                        // $bermissingreportpool = PoolPallet::find($pool_pallet_id);
                        $damagedreporttrans = Transporter::find($transporter_id);
                        $alltransaction = Alltransaction::create([
                            'reference_damaged_pallet_id' => $damagedpallet->damaged_pallet_id,
                            'sender/reporter' => $reporter,
                            'status' => 'REPORTED',
                            // 'pool_pallet' => $bermissingreportpool->pool_name,
                            'transporter' => $damagedreporttrans->transporter_name,
                            'tbr_pallet' => $damagedpallet->tbr_pallet,
                            'note' => $request->note,
                        ]);
                    }
                DB::commit();
                return response()->json(['status' => 'success'], 200);
            }catch (\Exception $e) {
                DB::rollback();
                return response()->json([
                    'status' => 'error',
                    'data' => $e->getMessage(),
                    'message' => 'Error Damaged Pallet Pallet Record'], 422);
                }
        }
    }

    public function destroy($id)
    {
        $damagedpallet = Damagedpallet::find($id);
        $reporter_user = User::find($damagedpallet->reporter_user_id);
        $pool_pallet = PoolPallet::find($damagedpallet->pool_pallet_id);
        $transporter = Transporter::find($damagedpallet->transporter_id);
        DB::beginTransaction();
        try{

            if($transporter == null){
                $deleted_item = DeletedItem::create([
                    'dp_number' => $damagedpallet->bmp_number,
                    // 'sjps_number' => $sjp_status->sjps_number,
                    'pool_pallet' => $pool_pallet->pool_name,
                    // 'transporter' => $transporter->transporter_name,
                    'reporter/sender' => $reporter_user->name,
                    // 'receiver/approver' => $approver_user->name,
                    'tbr_pallet' => $damagedpallet->tbr_pallet,
                    'created_by' => auth()->user()->name,
                    'note' => $damagedpallet->note,
                ]);
            }else{
                $deleted_item = DeletedItem::create([
                    'dp_number' => $damagedpallet->bmp_number,
                    // 'pool_pallet' => $pool_pallet->pool_name,
                    'transporter' => $transporter->transporter_name,
                    'reporter/sender' => $reporter_user->name,
                    // 'receiver/approver' => $approver_user->name,
                    'tbr_pallet' => $damagedpallet->tbr_pallet,
                    'created_by' => auth()->user()->name,
                    'note' => $damagedpallet->note,
                ]);
            }
            $damagedpallet->delete(); //KEMUDIAN HAPUS DATA TERSEBUT

        DB::commit();
        return response()->json(['status' => 'success'], 200);

        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Delete Damaged Pallet Record'], 422);
        }
    }
}
