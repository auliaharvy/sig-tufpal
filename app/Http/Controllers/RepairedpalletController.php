<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Repairedpallet;
use App\PoolPallet;
use App\Alltransaction;
use DB;

class RepairedpalletController extends Controller
{
    public function index()
    {
            $repairedpallet = DB::table('repaired_pallet as a')
            ->join('pool_pallet as b', 'a.pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('users as c', 'a.reporter_user_id', '=', 'c.id')
            ->select('a.*', 'b.pool_name', 'c.name')
            ->paginate(10000000)
            ->toArray();
		 return $repairedpallet;
        // return response()->json(Sjp::all()->toArray());
    }

    public function show($repaired_pallet_id)
    {
        $damagedpallet = Damagedpallet::find($repaired_pallet_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $repairedpallet]);
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'good_pallet' => 'required|gt:0',
        ]);

        $repaired_pallet_id = $request->repaired_pallet_id;
        $pool_pallet_id = 2;
        $pallet = PoolPallet::find($pool_pallet_id); //jgn lupa add model poolpallet
        $poolname = $pallet->pool_name;
        $qty_pool = $pallet->tbr_pallet;
        $pallet_qty = $request->good_pallet;

        if($pallet_qty>$qty_pool)
        {
            return response()->json([
                'status' => 'error', 
                'message' => 'the number of pallets exceeds the existing pallets in '. $poolname], 422);
        }
        else {
            DB::beginTransaction();
            try{
                $repairedpallet = Repairedpallet::create([
                    'reporter_user_id' => auth()->user()->id,
                    'pool_pallet_id' => $pool_pallet_id, 
                    'good_pallet' => $request->good_pallet, 
                    'note' => $request->note, 
                ]);
                
                $InventoryPool = PoolPallet::find($pool_pallet_id);
                $InventoryPool->tbr_pallet = (($InventoryPool->tbr_pallet)-($request->good_pallet));
                $InventoryPool->good_pallet = (($InventoryPool->good_pallet)+($request->good_pallet));
                $InventoryPool->save();
           
                // Membuat log All Transaction
                $reporter = Auth::user()->name;
                $poolpallet = PoolPallet::find($pool_pallet_id);
                $alltransaction = Alltransaction::create([
                    'reference_repaired_pallet_id' => $repairedpallet->repaired_pallet_id,
                    'transaction' => 'Repaired Pallet Report',
                    'sender/reporter' => $reporter,
                    'status' => 'REPORTED',
                    'pool_pallet' => $poolpallet->pool_name,
                    'good_pallet' => $repairedpallet->good_pallet,
                    'note' => $request->note,
                ]);

                DB::commit();
                return response()->json(['status' => 'success'], 200);
    
            }catch (\Exception $e) {
                DB::rollback();
                return response()->json([
                    'status' => 'error', 
                    'data' => $e->getMessage(),
                    'message' => 'Error Repair Pallet Record'], 422);
            }
        }
        
    }

    public function destroy($id)
    {
        $repairedpallet = Repairedpallet::find($id); //QUERY DATA BERDASARKAN ID
        $repairedpallet->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
