<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DateTime;
use App\Http\Resources\SjpCollection;
use App\Sjp;
use App\PoolPallet;
use App\Sjpadjusment;
use App\Sjpchangedestination;
use App\Transporter;
use App\Vehicle;
use App\Driver;
use DB;
use App\Alltransaction;
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
        $role = Auth::user()->role;
        $status = 'OPEN';
        if($pool_pallet=="pooldli" && $role<6){
            $sjp = DB::table('surat_jalan_pallet as a')
            ->join('pool_pallet as b', 'a.destination_pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('pool_pallet as c', 'a.departure_pool_pallet_id', '=', 'c.pool_pallet_id')
            ->join('vehicle as d', 'a.vehicle_id', '=', 'd.vehicle_id')
            ->join('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
            ->join('driver as f', 'a.driver_id', '=', 'f.driver_id')
            ->select('a.*', 'b.pool_name as dest_pool', 'c.pool_name as dept_pool',
                    'd.vehicle_number','e.transporter_name', 'f.driver_name')
             ->where('a.status',$status)
            ->paginate(1000000)
            ->toArray();
        }
        else{
            $sjp = DB::table(DB::raw('(SELECT * FROM surat_jalan_pallet WHERE status = "OPEN")a'))
            ->join('pool_pallet as b', 'a.departure_pool_pallet_id', '=', 'b.pool_pallet_id')
            ->join('pool_pallet as c', 'a.destination_pool_pallet_id', '=', 'c.pool_pallet_id')
            ->join('vehicle as d', 'a.vehicle_id', '=', 'd.vehicle_id')
            ->join('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
            ->join('driver as f', 'a.driver_id', '=', 'f.driver_id')
            ->select('a.*', 'b.pool_name as dept_pool', 'c.pool_name as dest_pool',
                    'd.vehicle_number','e.transporter_name', 'f.driver_name')
            ->where('b.pool_pallet_id',$pool_pallet)
            ->orWhere('c.pool_pallet_id',$pool_pallet)
            ->orWhere('a.transporter_id',$transporter)
            ->paginate(1000000)
            ->toArray();
        }

        // // $sjp = new SjpCollection($sjp1);
        return $sjp;
    }

    public function checkTruck(Request $request)
    {
        $vehicle = $request->vehicle_number;
        $status = 'OPEN';
        $sjpTruckOpen = DB::table('surat_jalan_pallet as a')
        ->join('pool_pallet as b', 'a.destination_pool_pallet_id', '=', 'b.pool_pallet_id')
        ->join('pool_pallet as c', 'a.departure_pool_pallet_id', '=', 'c.pool_pallet_id')
        ->join('vehicle as d', 'a.vehicle_id', '=', 'd.vehicle_id')
        ->join('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
        ->join('driver as f', 'a.driver_id', '=', 'f.driver_id')
        ->select('a.*', 'b.pool_name as dest_pool', 'c.pool_name as dept_pool',
                'd.vehicle_number','e.transporter_name', 'f.driver_name')
        ->where('a.status',$status)
        ->where('a.vehicle_id',$vehicle)
        // ->paginate(1000000)
        ->get();
       

        // // $sjp = new SjpCollection($sjp1);
        return $sjpTruckOpen;
    }

    public function store(Request $request)
    {
        $now = new DateTime();
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $pallet = PoolPallet::find($pool_pallet); //jgn lupa add model poolpallet
        $qty_pool = $pallet->good_pallet;
        $pallet_qty = $request->tonnage/2;

        if($pool_pallet=='pooldli'){ //jika pengiriman dari pool pallet DLI (Main Distribution)
            $distribution = 0;
        }
        else if($pool_pallet!='pooldli'){ //pengiriman bukan dari pool pallet DLI (Secondary Distribution)
            $distribution = 1;
        }



        $this->validate($request, [
            'destination_pool_pallet_id' => 'required',
            'vehicle_id' => 'required',
            'driver_id' => 'required',
            'transporter_id' => 'required',
            'no_do' => 'required|string|unique:surat_jalan_pallet,no_do',
            'product_name' => 'required|string',
            'pallet_quantity' => 'required|integer|gt:-1|lte:'.$qty_pool,
            'tonnage' => 'required|integer|gt:-1',
            'product_quantity' => 'required|integer|gt:-1',
        ]);
        if($qty_pool<$pallet_qty)
        {
            return response()->json([
                'status' => 'error',
                'message' => 'the number of pallets to be sent exceeds the number of pallets in the pool'], 422);
        }
        else{
            DB::beginTransaction();
            try{
                $checked_pool_pallet_id = DB::table('pool_pallet')
                    ->where('pool_pallet_id', '=', $request->destination_pool_pallet_id)
                    ->first();
                if($checked_pool_pallet_id == null && $pool_pallet == 'pooldli'){
                    $new_pool_pallet = PoolPallet::create([
                        'pool_pallet_id' => $request->destination_pool_pallet_id,
                        'organization_id' => 1,
                        'code' => $request->destination_pool_pallet_id,
                        'type' => 'WAREHOUSE',
                        'pool_name' => $request->pool_name,
                        'pool_address' => $request->pool_name,
                        'pallet_quota' => 100,
                        'created_by' => 'Autocreate in SJP No.Dispatch:'.$request->no_do,
                    ]);
                }elseif($checked_pool_pallet_id == null && $pool_pallet != 'pooldli'){
                    $new_pool_pallet = PoolPallet::create([
                        'pool_pallet_id' => $request->destination_pool_pallet_id,
                        'organization_id' => 1,
                        'code' => $request->destination_pool_pallet_id,
                        'type' => 'SHOP',
                        'pool_name' => $request->pool_name,
                        'pool_address' => $request->pool_name,
                        'pallet_quota' => 100,
                        'created_by' => 'Autocreate in SJP No.Dispatch:'.$request->no_do,
                    ]);
                }

                $checked_transporter_id = DB::table('transporter')
                    ->where('transporter_id', '=', $request->transporter_id)
                    ->first();
                if($checked_transporter_id == null){
                    $new_transporter = Transporter::create([
                        'transporter_id' => $request->transporter_id,
                        'transporter_name' => $request->transporter_name,
                        'organization_id' => 1,
                        'transporter_code' => $request->transporter_id,
                        'pallet_quota' => 100,
                        'created_by' => 'Autocreate in SJP No.Dispatch: '.$request->no_do,
                    ]);
                }

                $checked_driver_id = DB::table('driver')
                    ->where('driver_id', '=', $request->driver_id)
                    ->first();
                if($checked_driver_id == null){
                    $new_driver = Driver::create([
                        'driver_id' => $request->driver_id,
                        'transporter_id' => $request->transporter_id,
                        'driver_name' => $request->driver_name,
                        'created_by' => 'Autocreate in SJP No.Dispatch:'.$request->no_do,
                    ]);
                }

                $checked_vehicle_id = DB::table('vehicle')
                    ->where('vehicle_id', '=', $request->vehicle_id)
                    ->first();
                if($checked_vehicle_id == null){
                    $new_vehilce = Vehicle::create([
                        'vehicle_id' => $request->vehicle_id,
                        'transporter_id' => $request->transporter_id,
                        'vehicle_number' => $request->vehicle_id,
                        'vehicle_type' => 'Tronton',
                        'created_by' => 'Autocreate in SJP No.Dispatch:'.$request->no_do,
                    ]);
                }



                $sjp = Sjp::create([
                    'destination_pool_pallet_id' => $request->destination_pool_pallet_id,
                    'departure_pool_pallet_id' => $pool_pallet,
                    'vehicle_id' => $request->vehicle_id,
                    'driver_id' => $request->driver_id,
                    'transporter_id' => $request->transporter_id,
                    //'sjp_number' => $request->sjp_number,
                    'no_do' => $request->no_do,
                    'product_name' => $request->product_name,
                    'tonnage' => $request->tonnage,
                    'packaging' => $request->packaging,
                    'product_quantity' => $request->product_quantity,
                    'status' => 'OPEN',
                    'state' => 0,
                    'created_by' => auth()->user()->name,
                    'is_sendback' => 0,
                    'distribution' => $distribution,
                    // 'created_at' => $now,
                    // 'updated_at' => null,
                    'departure_time' => $request->departure_time,
                    'eta' => $request->eta,
                    'pallet_quantity' => $request->pallet_quantity,
                ]);
                DB::commit();
                return response()->json(['status' => 'success',
                                            'data' => $checked_pool_pallet_id], 200);

            }catch (\Exception $e) {
                DB::rollback();
                return response()->json([
                    'status' => 'error',
                    'data' => $e->getMessage(),
                    'message' => 'Error Surat Jalan Pallet Record'], 422);
            }
        }
    }

    public function edit($id)
    {
        $sjp = Sjp::find($id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $sjp]);
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

        $this->validate($request, [
            'vehicle_id' => 'required',
            'driver_id' => 'required',

        ]);
        $sjp = Sjp::where('sjp_id',$sjp_id)->first();
        if (empty($sjp)){
            return response()->json(['error' => 'Data not found'], 404);
        }
        else{
            DB::beginTransaction();
            try{
                $update = Sjp::find($sjp_id);
                $update->driver_id = $request->driver_id;
                $update->vehicle_id = $request->vehicle_id;
                $update->adjust_by = auth()->user()->name;
                $update->save();

                // Membuat log All Transaction
                $reporter = Auth::user()->name;
                $sjp_number = $sjp->sjp_number;
                $transporter_id = $sjp->transporter_id;
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
                $alltransaction = Alltransaction::create([
                    'reference_sjp_id' => $update->sjp_id,
                    'transaction' => 'Surat Jalan Pallet Adjusment',
                    'sender/reporter' => $reporter,
                    'status' => 'ADJUST',
                    'transporter' => $transporter->transporter_name,
                    'vehicle' => $vehicle->vehicle_number,
                    'new_vehicle' => $new_vehicle->vehicle_number,
                    'driver' => $driver->driver_name,
                    'new_driver' => $new_driver->driver_name,
                    'note' => $request->note,
                ]);

                //Buat Log Sjp Ajdusment
                $sjp_number = $sjp->sjp_number;
                $transporter_id = $sjp->transporter_id;
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

                DB::commit();
                return response()->json(['status' => 'success'], 200);

            }catch (\Exception $e) {
                DB::rollback();
                return response()->json([
                    'status' => 'error',
                    'data' => $e->getMessage(),
                    'message' => 'Error Adjusment Surat Jalan Pallet Record'], 422);
            }
        }
    }

    public function changedestination(Request $request)
    {
        $sjp_id = $request->sjp_id;

        $sjp = Sjp::where('sjp_id',$sjp_id)->first();
        if (empty($sjp)){
            return response()->json(['error' => 'Data not found'], 404);
        }
        else{
            DB::beginTransaction();
            try{
                $update = Sjp::find($sjp_id);
                // $update->driver_id = $request->driver_id;
                // $update->driver_id = $request->driver_id;
                // $update->vehicle_id = $request->vehicle_id;
                $update->no_do = $request->no_do;
                $update->destination_pool_pallet_id = $request->destination_pool_pallet_id;
                $update->adjust_by = auth()->user()->name;
                $update->save();

                // Membuat log All Transaction
                $reporter = Auth::user()->name;
                $sjp_number = $sjp->sjp_number;
                $no_do = $sjp->no_do;
                $new_no_do = $request->no_do;
                $transporter_id = $sjp->transporter_id;
                $transporter = Transporter::find($transporter_id);
                $vehicle_id = $sjp->vehicle_id;
                $vehicle = Vehicle::find($vehicle_id);
                $destination_pool_pallet_id = $sjp->destination_pool_pallet_id;
                $destination = PoolPallet::find($destination_pool_pallet_id);
                $new_destination_id = $request->destination_pool_pallet_id;
                $new_destination = PoolPallet::find($new_destination_id);
                $alltransaction = Alltransaction::create([
                    'reference_sjp_id' => $update->sjp_id,
                    'transaction' => 'Surat Jalan Pallet Change Destination',
                    'sender/reporter' => $reporter,
                    'status' => 'ADJUST',
                    'no_do' => $no_do,
                    'new_no_do' => $new_no_do,
                    'destination_pool' => $destination->pool_name,
                    'new_destination' => $new_destination->pool_name,
                    'note' => $request->note,
                ]);


                // Buat Log SJP Change Destination
                $sjp_number = $sjp->sjp_number;
                $no_do = $sjp->no_do;
                $new_no_do = $request->no_do;
                $transporter_id = $sjp->transporter_id;
                $transporter = Transporter::find($transporter_id);
                $vehicle_id = $sjp->vehicle_id;
                $vehicle = Vehicle::find($vehicle_id);
                $destination_pool_pallet_id = $sjp->destination_pool_pallet_id;
                $destination = PoolPallet::find($destination_pool_pallet_id);
                $new_destination_id = $request->destination_pool_pallet_id;
                $new_destination = PoolPallet::find($new_destination_id);
                $checker = Auth::user()->name;
                $sjpchangedest = Sjpchangedestination::create([
                    'sjp_number' => $sjp_number,
                    'no_do' => $no_do,
                    'new_no_do' => $new_no_do,
                    'destination' => $destination->pool_name,
                    'new_destination' => $new_destination->pool_name,
                    'adjust_by' => $checker,
                ]);
                DB::commit();
                return response()->json(['status' => 'success'], 200);

            }catch (\Exception $e) {
                DB::rollback();
                return response()->json([
                    'status' => 'error',
                    'data' => $e->getMessage(),
                    'message' => 'Error Change Destination Surat Jalan Pallet Record'], 422);
            }
        }
    }

    public function destroy($id)
    {
        $sjp = Sjp::find($id); //QUERY DATA BERDASARKAN ID
        $sjp->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
