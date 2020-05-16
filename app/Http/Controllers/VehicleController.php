<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Vehicle;
use DB;

class VehicleController extends Controller
{
    public function index()
    {
        // $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        if($transporter==null && $role<5){
        $vehicle = DB::table('vehicle as a')
            ->join('transporter as b', 'a.transporter_id', '=', 'b.transporter_id')
            ->select('a.*', 'b.transporter_name')
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $vehicle = DB::table('vehicle as a')
            ->join('transporter as b', 'a.transporter_id', '=', 'b.transporter_id')
            ->select('a.*', 'b.transporter_name')
            ->where('a.transporter_id', $transporter)
            ->paginate(1000000)
            ->toArray();
        }

        // $pool = new SjpStatusCollection(PoolPallet::paginate(10));
		 return $vehicle;
        // return response()->json(Sjp::all()->toArray());
    }

    public function getvehicleform()
    {
        // $sjp = new SjpCollection(Sjp::paginate(10));
		//  return $sjp;
        // return response()->json(Sjp::all()->toArray());

            $vehicle = DB::table('vehicle as a')
            ->select('a.*')
            // ->leftJoin(DB::raw('(SELECT * FROM surat_jalan_pallet WHERE STATUS = "OPEN")sjp'),
            // function($join){
            //     $join->on('a.vehicle_id','=','sjp.vehicle_id');
            // })
            // ->leftJoin(DB::raw('(SELECT * FROM pallet_transfer WHERE STATUS = 0)plt'),
            // function($join){
            //     $join->on('a.vehicle_id','=','plt.vehicle_id');
            // })
            // // ->join('"SELECT * FROM surat_jalan_pallet WHERE STATUS = OPEN" as b', 'a.driver_id', '=', 'b.driver_i','left')
            // // // ->join('pallet_transfer as c', 'a.driver_id', '=', 'c.driver_id','left outer')

            // ->where('sjp.vehicle_id',NULL)
            // ->where('plt.vehicle_id',NULL)
            ->paginate(100000)
            ->toArray();


        // // $sjp = new SjpCollection($sjp1);
        return $vehicle;
    }

    public function store(Request $request)
    {

        $this->validate($request, [
            'vehicle_number' => 'required|unique:vehicle,vehicle_number',
            'vehicle_type' => 'required',
        ]);

        DB::beginTransaction();
        try{
            $created_by = Auth::user()->name;
            $vehicle = Vehicle::create([
                'transporter_id' => $request->transporter_id,
                'vehicle_id' => $request->vehicle_number,
                'vehicle_number' => $request->vehicle_number,
                'vehicle_type' => $request->vehicle_type,
                'created_by' => $created_by
            ]);
            DB::commit();
            return response()->json(['status' => 'success'], 200);

        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Create Vehicle'], 422);
        }
    }

    public function edit($id)
    {
        $vehicle = Vehicle::find($id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $vehicle]);
    }

    public function update(Request $request, $id)
    {
        //VALIDASI DATA YANG DITERIMA
        $this->validate($request, [
            'vehicle_number' => 'required|',
            'vehicle_type' => 'required',
        ]);

        DB::beginTransaction();
        try{
            $created_by = Auth::user()->name;
            $update = Vehicle::find($id);
            $update->transporter_id = $request->transporter_id;
            $update->vehicle_number = $request->vehicle_number;
            $update->vehicle_id = $request->vehicle_number;
            $update->vehicle_type = $request->vehicle_type;
            $update->updated_by = $created_by;
            $update->save();
            DB::commit();
            return response()->json(['status' => 'success'], 200);
        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Update Vehicle Record'], 422);
        }
    }

    public function destroy($id)
    {
        $vehicle = Vehicle::find($id); //QUERY DATA BERDASARKAN ID
        $vehicle->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }


}
