<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpCollection;
use App\Sjp;
use DB;
use Illuminate\Support\Collection;

class SjpController extends Controller
{
    public function index()
    {
        // $sjp = new SjpCollection(Sjp::paginate(10));
		//  return $sjp;
        // return response()->json(Sjp::all()->toArray());

        $sjp = DB::table('surat_jalan_pallet as a')
            ->join('pool_pallet as b', 'a.destination_pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('pool_pallet as c', 'a.departure_pool_pallet_id', '=', 'c.pool_pallet_id')
            ->join('vehicle as d', 'a.vehicle_id', '=', 'd.vehicle_id')
            ->join('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
            ->join('driver as f', 'a.driver_id', '=', 'f.driver_id')
            ->select('a.*', 'b.pool_name as dest_pool', 'c.pool_name as dept_pool',
                    'd.vehicle_number','e.transporter_name', 'f.driver_name')
            ->paginate(10)
            ->toArray();
        // // $sjp = new SjpCollection($sjp1);
        return $sjp;
    }

    public function store(Request $request)
    {
        $sjp = Sjp::create([
            'destination_pool_pallet_id' => $request->destination_pool_pallet_id, 
            'departure_pool_pallet_id' => $request->departure_pool_pallet_id, 
            'vehicle_id' => $request->vehicle_id, 
            'driver_id' => $request->driver_id, 
            'transporter_id' => $request->transporter_id, 
            //'sjp_number' => $request->sjp_number, 
            'no_do' => $request->no_do, 
            'product_name' => $request->product_name, 
            'packaging' => $request->packaging, 
            'product_quantity' => $request->product_quantity, 
            'status' => 'OPEN', 
            'departure_time' => $request->departure_time, 
            'eta' => $request->eta, 
            'pallet_quantity' => $request->pallet_quantity, 
        ]);

        $data = [
            'data' => $sjp,
            'status' => (bool) $sjp,
            'message' => $sjp ? 'Surat jalan Pallet Record Created!' : 'Error Creating Surat jalan Pallet Record' 
        ];

        return response()->json($data);
    }

    public function edit($id)
    {
        $sjp = Sjp::find($id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $sjp]);
    }

    public function update(Request $request, $id)
    {
        //VALIDASI DATA YANG DITERIMA
        $this->validate($request, [
            'destination_pool_pallet_id' => 'required',
            'departure_pool_pallet_id' => 'required',
            'sjp_number' => 'required|string'
        ]);

        $sjp = Sjp::find($id); //QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        $sjp->update($request->all()); //UPDATE DATA BERDASARKAN DATA YANG DITERIMA
        return response()->json(['status' => 'success']);
    }

    public function destroy($id)
    {
        $sjp = Sjp::find($id); //QUERY DATA BERDASARKAN ID
        $sjp->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
