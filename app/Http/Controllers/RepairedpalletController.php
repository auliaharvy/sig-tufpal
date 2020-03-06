<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Repairedpallet;
use App\PoolPallet;
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
        $qty_pool = $pallet->tbr_pallet;
        $pallet_qty = $request->good_pallet;

        if($pallet_qty>$qty_pool)
        {
            return response()->json(['error' => 'Pallet Melebihi Quantity yang ada'], 404);
        }
        else {
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
           
    
            $data = [
                'data' => $repairedpallet,
                'status' => (bool) $repairedpallet,
                'message' => $repairedpallet ? 'Damaged Pallet Record Created!' : 'Error Damaged Pallet Record' 
            ];
    
            return response()->json($data);
        }
        
    }

    public function destroy($id)
    {
        $repairedpallet = Repairedpallet::find($id); //QUERY DATA BERDASARKAN ID
        $repairedpallet->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
