<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DateTime;
use App\Http\Resources\SjpCollection;
use App\Sjp;
use App\PoolPallet;
use App\Sjpadjusment;
use App\Transporter;
use App\Vehicle;
use App\Driver;
use DB;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Auth;

class SjpController extends Controller
{
    public function index()
    {
        // $sjp = new SjpCollection(Sjp::paginate(10));
		//  return $sjp;
        // return response()->json(Sjp::all()->toArray());
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $status = 'OPEN';
        $role = Auth::user()->role;
        if($pool_pallet==1 && $role<7){
            $sjp = DB::table('surat_jalan_pallet as a')
            ->join('pool_pallet as b', 'a.destination_pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('pool_pallet as c', 'a.departure_pool_pallet_id', '=', 'c.pool_pallet_id')
            ->join('vehicle as d', 'a.vehicle_id', '=', 'd.vehicle_id')
            ->join('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
            ->join('driver as f', 'a.driver_id', '=', 'f.driver_id')
            ->select('a.*', 'b.pool_name as dest_pool', 'c.pool_name as dept_pool',
                    'd.vehicle_number','e.transporter_name', 'f.driver_name')
            // ->where('a.status', $status)
            ->paginate(1000000)
            ->toArray();
        }
        else{
            $sjp = DB::table('surat_jalan_pallet as a')
            ->join('pool_pallet as b', 'a.destination_pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('pool_pallet as c', 'a.departure_pool_pallet_id', '=', 'c.pool_pallet_id')
            ->join('vehicle as d', 'a.vehicle_id', '=', 'd.vehicle_id')
            ->join('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
            ->join('driver as f', 'a.driver_id', '=', 'f.driver_id')
            ->select('a.*', 'b.pool_name as dest_pool', 'c.pool_name as dept_pool',
                    'd.vehicle_number','e.transporter_name', 'f.driver_name')
            // ->where('a.status', $status) 
            ->where('c.pool_pallet_id',$pool_pallet)
            ->orWhere('b.pool_pallet_id', $pool_pallet)
            ->orWhere('e.transporter_id', $transporter)
            ->paginate(1000000)
            ->toArray();
        }
       
        // // $sjp = new SjpCollection($sjp1);
        return $sjp;
    }

    public function store(Request $request)
    {
        $now = new DateTime();
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $pallet = PoolPallet::find($pool_pallet); //jgn lupa add model poolpallet
        $qty_pool = $pallet->good_pallet;
        $pallet_qty = $request->pallet_quantity;

        $this->validate($request, [
            // 'destination_pool_pallet_id' => 'required',
            // 'vehicle_id' => 'required',
            // 'driver_id' => 'required',
            // 'transporter_id' => 'required',
            'no_do' => 'required|string',
            'product_name' => 'required|string',
            'pallet_quantity' => 'required|integer|gt:-1|lte:'.$qty_pool,
            'packaging' => 'required|integer|gt:-1',
            'product_quantity' => 'required|integer|gt:-1',
        ]);
            $sjp = Sjp::create([
            'destination_pool_pallet_id' => $request->destination_pool_pallet_id, 
            'departure_pool_pallet_id' => $pool_pallet, 
            'vehicle_id' => $request->vehicle_id, 
            'driver_id' => $request->driver_id, 
            'transporter_id' => $request->transporter_id, 
            //'sjp_number' => $request->sjp_number, 
            'no_do' => $request->no_do, 
            'product_name' => $request->product_name, 
            'packaging' => $request->packaging, 
            'product_quantity' => $request->product_quantity, 
            'status' => 'OPEN',
            'state' => 0,
            'created_by' => auth()->user()->name,
            'is_sendback' => 0,
            // 'created_at' => $now,
            // 'updated_at' => null,
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

    //Codingan Pertama
    // public function store(Request $request)
    // {
    //     $now = new DateTime();

    //     $sjp = Sjp::create([
    //         'destination_pool_pallet_id' => $request->destination_pool_pallet_id, 
    //         'departure_pool_pallet_id' => Auth::user()->reference_pool_pallet_id, 
    //         'vehicle_id' => $request->vehicle_id, 
    //         'driver_id' => $request->driver_id, 
    //         'transporter_id' => $request->transporter_id, 
    //         //'sjp_number' => $request->sjp_number, 
    //         'no_do' => $request->no_do, 
    //         'product_name' => $request->product_name, 
    //         'packaging' => $request->packaging, 
    //         'product_quantity' => $request->product_quantity, 
    //         'status' => 'OPEN',
    //         'state' => 0,
    //         'created_by' => auth()->user()->name,
    //         'created_at' => $now,
    //         'updated_at' => null,
    //         'departure_time' => $request->departure_time, 
    //         'eta' => $request->eta, 
    //         'pallet_quantity' => $request->pallet_quantity, 
    //     ]);

    //     $data = [
    //         'data' => $sjp,
    //         'status' => (bool) $sjp,
    //         'message' => $sjp ? 'Surat jalan Pallet Record Created!' : 'Error Creating Surat jalan Pallet Record' 
    //     ];

    //     return response()->json($data);
    // }

    public function edit($id)
    {
        $sjp = Sjp::find($id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $sjp]);

        // $sjp = DB::table('surat_jalan_pallet as a')
        // ->join('pool_pallet as b', 'a.destination_pool_pallet_id', '=', 'b.pool_pallet_id')
        // ->join('pool_pallet as c', 'a.departure_pool_pallet_id', '=', 'c.pool_pallet_id')
        // ->join('vehicle as d', 'a.vehicle_id', '=', 'd.vehicle_id')
        // ->join('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
        // ->join('driver as f', 'a.driver_id', '=', 'f.driver_id')
        // // ->select('a.*', 'b.pool_name as dest_pool', 'c.pool_name as dept_pool',
        // //         'd.vehicle_number','e.transporter_name', 'f.driver_name')
        // ->select('*')
        // ->where('sjp_id',$id)
        
        // ->get();
        //  return response()->json(['status' => 'success', 'data' => $sjp]);
    }

    public function update(Request $request, $id) //sjp adjusment
    {
        //VALIDASI DATA YANG DITERIMA
        $this->validate($request, [
            'vehicle_id' => 'required',
            'driver_id' => 'required',
            
        ]);

        $sjp = Sjp::find($id); //QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        $sjp->update($request->all()); //UPDATE DATA BERDASARKAN DATA YANG DITERIMA
        return response()->json(['status' => 'success']);
    }

    public function adjust(Request $request)
    {
        $sjp_id = $request->sjp_id;

        $sjp = Sjp::where('sjp_id',$sjp_id)->first();
        if (empty($sjp)){
            return response()->json(['error' => 'Data not found'], 404);
        }
        else{
            $update = Sjp::find($sjp_id);
            $update->driver_id = $request->driver_id;
            $update->vehicle_id = $request->vehicle_id;
            $update->adjust_by = auth()->user()->name;
            $update->save();

            

        }

            $sjp_number = $sjp->sjp_number;
            $transporter_id = $sjp->vehicle_id;
            $transporter = Transporter::find($transporter_id);
            $vehicle_id = $sjp->vehicle_id;
            $vehicle = Vehicle::find($vehicle_id);
            $driver_id = $sjp->driver_id;
            $driver = Driver::find($driver_id);
            $checker = Auth::user()->name;
            $new_vehicle_id = $request->vehicle_id;
            $new_vehicle = Vehicle::find($new_vehicle_id);
            $new_driver_id = $request->driver_id;
            $new_driver = Driver::find($new_driver_id); 
            $sjpadusment = Sjpadjusment::create([
                'sjp_number' => $sjp_number,
                'transporter' => $transporter->transporter_name,
                'vehicle' => $vehicle->vehicle_number,
                'new_vehicle' => $new_vehicle->vehicle_number,
                'driver' => $driver->driver_name,
                'new_driver' => $new_driver->driver_name,
                'adjust_by' => $checker, 
            ]);

        $data = [
            'data' => $update,
            'status' => (bool) $update,
            'message' => $update ? 'SJP Record Updated!' : 'Error Updating SJP  Record' 
        ];

        return response()->json($data);
    }

    public function destroy($id)
    {
        $sjp = Sjp::find($id); //QUERY DATA BERDASARKAN ID
        $sjp->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
