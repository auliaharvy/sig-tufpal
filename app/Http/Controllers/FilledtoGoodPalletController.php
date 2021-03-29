<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Filledtogoodpallet;
use App\PoolPallet;
use App\DeletedItem;
use App\Alltransaction;
use DB;

class FilledtoGoodPalletController extends Controller
{
    public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        if($pool_pallet=='pooldli' && $role<5){
            $filled_to_good = DB::table('pallet_filled_to_good as a')
            ->orderBy('created_at', 'DESC')
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->join('pool_pallet as c', 'a.pool_pallet_id', '=', 'c.pool_pallet_id')
            ->join('sjp_status as d', 'a.reference_sjp_status_id', '=', 'd.sjp_status_id')
            ->select('a.*', 'b.name',
                    'c.pool_name', 'd.sjps_number')
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $filled_to_good = DB::table('pallet_filled_to_good as a')
            ->orderBy('created_at', 'DESC')
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->join('pool_pallet as c', 'a.pool_pallet_id', '=', 'c.pool_pallet_id')
            ->select('a.*', 'b.name', 'c.pool_name')
            ->where('a.pool_pallet_id',$pool_pallet)
            ->paginate(10000000)
            ->toArray();
        }
        return $filled_to_good;
    }

    public function show($filled_to_good_id)
    {
        $filled_to_good = Filledtogoodpallet::find($filled_to_good_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $filled_to_good]);
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'good_pallet' => 'required|gt:0',
            'note' => 'required',
        ]);

        $pool_pallet_id = auth()->user()->reference_pool_pallet_id;
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
                $filledToGood = Filledtogoodpallet::create([
                    'reporter_user_id' => auth()->user()->id,
                    'pool_pallet_id' => auth()->user()->reference_pool_pallet_id,
                    'good_pallet' => $request->good_pallet,
                    'note' => $request->note,
                ]);
                    if($pool_pallet_id!=null){
                        $InventoryPool = PoolPallet::find($pool_pallet_id);
                        $InventoryPool->filled_pallet = (($InventoryPool->filled_pallet)-($request->good_pallet));
                        $InventoryPool->good_pallet = (($InventoryPool->good_pallet)+($request->good_pallet));
                        $InventoryPool->save();
                    }

                    // Membuat log All Transaction
                    if($pool_pallet_id!=null){
                        $reporter = Auth::user()->name;
                        $pool_pallet_id = Auth::user()->reference_pool_pallet_id;
                        $damagedreportpool = PoolPallet::find($pool_pallet_id);
                        // $bermissingreporttrans = Transporter::find($transporter_id);
                        $alltransaction = Alltransaction::create([
                            'reference_filled_to_good_id' => $filledToGood->filled_to_good_id,
                            'transaction' => 'Filled To Good Pallet Report',
                            'sender/reporter' => $reporter,
                            'status' => 'REPORTED',
                            'pool_pallet' => $damagedreportpool->pool_name,
                            // 'transporter' => $bermissingreporttrans->transporter_name,
                            'good_pallet' => $filledToGood->good_pallet,
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
                    'message' => 'Error Filled To Good Pallet Record'], 422);
                }
        }
    }

    public function destroy($id)
    {
        $filledToGood = Filledtogoodpallet::find($id);
        $reporter_user = User::find($filledToGood->reporter_user_id);
        $pool_pallet = PoolPallet::find($filledToGood->pool_pallet_id);
        $transporter = Transporter::find($filledToGood->transporter_id);
        DB::beginTransaction();
        try{

            $filledToGood->delete(); //KEMUDIAN HAPUS DATA TERSEBUT

        DB::commit();
        return response()->json(['status' => 'success'], 200);

        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Filled To Good Pallet Record'], 422);
        }
    }
}
