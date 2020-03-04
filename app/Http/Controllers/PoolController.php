<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\SjpStatus;
use App\Sjp;
use App\PoolPallet;
use DB;

class PoolController extends Controller
{
    public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $role = Auth::user()->role;
        if($pool_pallet==1 && $role<7){
        $pool = DB::table('pool_pallet as a')
            ->join('organization as b', 'a.organization_id', '=', 'b.organization_id')
            ->select('a.*', 'b.organization_name')
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $pool = DB::table('pool_pallet as a')
            ->join('organization as b', 'a.organization_id', '=', 'b.organization_id')
            ->select('a.*', 'b.organization_name')
            ->where('a.pool_pallet_id',[$pool_pallet])
            ->paginate(1000000)
            ->toArray();
        }

        // $pool = new SjpStatusCollection(PoolPallet::paginate(10));
		 return $pool;
        // return response()->json(Sjp::all()->toArray());
    }

    public function getpoolpallet()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        if($pool_pallet==null){
        $pool = DB::table('pool_pallet as a')
            ->join('organization as b', 'a.organization_id', '=', 'b.organization_id')
            ->select('a.*', 'b.organization_name')
            ->paginate(1000)
            ->toArray();
        }
        else{
            $pool = DB::table('pool_pallet as a')
            ->join('organization as b', 'a.organization_id', '=', 'b.organization_id')
            ->select('a.*', 'b.organization_name')
            ->whereNotIn('a.pool_pallet_id',[$pool_pallet])
            ->paginate(1000)
            ->toArray();
        }

        // $pool = new SjpStatusCollection(PoolPallet::paginate(10));
		 return $pool;
        // return response()->json(Sjp::all()->toArray());
    }

    public function store(Request $request)
    {
        $pool = PoolPallet::create([
            'organization_id' => $request->organization_id, 
            'code' => $request->code, 
            'type' => $request->type, 
            'pool_name' => $request->pool_name, 
            'pool_address' => $request->pool_address, 
            'pool_city' => $request->pool_city, 
            'phone_number' => $request->phone_number, 
            'pool_email' => $request->pool_email, 
            'pallet_quota' => $request->pallet_quota,
            'good_pallet' => $request->good_pallet, 
            'tbr_pallet' => $request->tbr_pallet, 
            'ber_pallet' => $request->ber_pallet, 
            'missing_pallet' => $request->missing_pallet, 
        ]);

        $data = [
            'data' => $pool,
            'status' => (bool) $pool,
            'message' => $pool ? 'Pool Pallet Created!' : 'Error Creating Pool Pallet' 
        ];

        return response()->json($data);
    }

    public function edit($id)
    {
        $pool = PoolPallet::find($id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $pool]);
    }

    public function update(Request $request, $id)
    {
        //VALIDASI DATA YANG DITERIMA
        $this->validate($request, [
            'pool_name' => 'required|string',
            'pool_address' => 'required|string',
            'pallet_quota' => 'required'
        ]);

        $pool = PoolPallet::find($id); //QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        $pool->update($request->all()); //UPDATE DATA BERDASARKAN DATA YANG DITERIMA
        return response()->json(['status' => 'success']);
    }

    public function destroy($id)
    {
        $pool = PoolPallet::find($id); //QUERY DATA BERDASARKAN ID
        $pool->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }

}
