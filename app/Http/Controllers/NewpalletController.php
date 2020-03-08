<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Newpallet;
use App\PoolPallet;
use DB;

class NewpalletController extends Controller
{
    public function index()
    {
            $newpallet = DB::table('new_pallet as a')
            ->join('pool_pallet as b', 'a.pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('users as c', 'a.adder_user_id', '=', 'c.id')
            ->select('a.*', 'b.pool_name', 'c.name')
            ->paginate(10000000)
            ->toArray();
		 return $newpallet;
        // return response()->json(Sjp::all()->toArray());
    }

    public function show($new_pallet_id)
    {
        $newpallet = Newpallet::find($new_pallet_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $newpallet]);
    }

    public function store(Request $request)
    {
        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1',
        ]);

        $new_pallet_id = $request->new_pallet_id;
        $pool_pallet_id = auth()->user()->reference_pool_pallet_id;

        $newpallet = Newpallet::create([
            'adder_user_id' => auth()->user()->id,
            'pool_pallet_id' => auth()->user()->reference_pool_pallet_id, 
            'good_pallet' => $request->good_pallet,
            'vehicle' => $request->vehicle,
            'driver' => $request->driver, 
            'vendor' => 'Pallet Vendor', 
            'note' => $request->note, 
        ]);
        
        $InventoryPool = PoolPallet::find($pool_pallet_id);
        $InventoryPool->good_pallet = (($InventoryPool->good_pallet)+($request->good_pallet));
        $InventoryPool->save();
       

        $data = [
            'data' => $newpallet,
            'status' => (bool) $newpallet,
            'message' => $newpallet ? 'BER/Missing Pallet Record Created!' : 'Error BER/Missing Pallet Record' 
        ];

        return response()->json($data);
    }

    public function destroy($id)
    {
        $newpallet = Newpallet::find($id); //QUERY DATA BERDASARKAN ID
        $newpallet->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
