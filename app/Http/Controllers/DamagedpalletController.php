<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Damagedpallet;
use App\PoolPallet;
use DB;

class DamagedpalletController extends Controller
{
    public function index()
    {
            $damagedpallet = DB::table('damaged_pallet as a')
            ->join('pool_pallet as b', 'a.pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('users as c', 'a.reporter_user_id', '=', 'c.id')
            ->select('a.*', 'b.pool_name', 'c.name')
            ->paginate(10000000)
            ->toArray();
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
            'tbr_pallet' => 'required',
        ]);

        $damaged_pallet_id = $request->damaged_pallet_id;
        $pool_pallet_id = auth()->user()->reference_pool_pallet_id;

        $damagedpallet = Damagedpallet::create([
            'reporter_user_id' => auth()->user()->id,
            'pool_pallet_id' => auth()->user()->reference_pool_pallet_id, 
            'tbr_pallet' => $request->tbr_pallet, 
            'note' => $request->note, 
        ]);
        
        $InventoryPool = PoolPallet::find($pool_pallet_id);
        $InventoryPool->good_pallet = (($InventoryPool->good_pallet)-($request->tbr_pallet));
        $InventoryPool->tbr_pallet = (($InventoryPool->tbr_pallet)+($request->tbr_pallet));
        $InventoryPool->save();
       

        $data = [
            'data' => $damagedpallet,
            'status' => (bool) $damagedpallet,
            'message' => $damagedpallet ? 'Damaged Pallet Record Created!' : 'Error Damaged Pallet Record' 
        ];

        return response()->json($data);
    }

    public function destroy($id)
    {
        $damagedpallet = Damagedpallet::find($id); //QUERY DATA BERDASARKAN ID
        $damagedpallet->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
