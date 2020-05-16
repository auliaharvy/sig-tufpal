<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Driver;
use DB;

class DriverController extends Controller
{
    public function index()
    {
        // $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        if($transporter==null && $role<5){
        $driver = DB::table('driver as a')
            ->join('transporter as b', 'a.transporter_id', '=', 'b.transporter_id')
            ->select('a.*', 'b.transporter_name')
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $driver = DB::table('driver as a')
            ->join('transporter as b', 'a.transporter_id', '=', 'b.transporter_id')
            ->select('a.*', 'b.transporter_name')
            ->where('a.transporter_id', $transporter)
            ->paginate(1000000)
            ->toArray();
        }

		 return $driver;
        // return response()->json(Sjp::all()->toArray());
    }

    public function getdriverform()
    {
        // $sjp = new SjpCollection(Sjp::paginate(10));
		//  return $sjp;
        // return response()->json(Sjp::all()->toArray());

            $driver = DB::table('driver as a')
            ->select('a.*')
            // ->leftJoin(DB::raw('(SELECT * FROM surat_jalan_pallet WHERE STATUS = "OPEN")sjp'),
            // function($join){
            //     $join->on('a.driver_id','=','sjp.driver_id');
            // })
            // ->leftJoin(DB::raw('(SELECT * FROM pallet_transfer WHERE STATUS = 0)plt'),
            // function($join){
            //     $join->on('a.driver_id','=','plt.driver_id');
            // })
            // // ->join('"SELECT * FROM surat_jalan_pallet WHERE STATUS = OPEN" as b', 'a.driver_id', '=', 'b.driver_i','left')
            // // // ->join('pallet_transfer as c', 'a.driver_id', '=', 'c.driver_id','left outer')

            // ->where('sjp.driver_id',NULL)
            // ->where('plt.driver_id',NULL)
            ->paginate(10000)
            ->toArray();


        // // $sjp = new SjpCollection($sjp1);
        return $driver;
    }

    public function store(Request $request)
    {

        $this->validate($request, [
            'driver_id' => 'required|unique:driver,driver_id',
            'driver_name' => 'required',
        ]);

        DB::beginTransaction();
        try{
            $created_by = Auth::user()->name;
            $driver = Driver::create([
                'transporter_id' => $request->transporter_id,
                'driver_id' => $request->driver_id,
                'driver_name' => $request->driver_name,
                'driver_address' => $request->driver_address,
                'mobile_number' => $request->mobile_number,
                'email' => $request->email,
                'created_by' => $created_by
            ]);
            DB::commit();
            return response()->json(['status' => 'success'], 200);

        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Create Driver'], 422);
        }
    }

    public function edit($id)
    {
        $driver = Driver::find($id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $driver]);
    }

    public function update(Request $request, $id)
    {
        //VALIDASI DATA YANG DITERIMA
        $this->validate($request, [
            'driver_id' => 'required',
            'driver_name' => 'required',
        ]);

        DB::beginTransaction();
        try{
            $created_by = Auth::user()->name;
            $update = Driver::find($id);
            $update->transporter_id = $request->transporter_id;
            $update->driver_id = $request->driver_id;
            $update->driver_name = $request->driver_name;
            $update->driver_address = $request->driver_address;
            $update->mobile_number = $request->mobile_number;
            $update->email = $request->email;
            $update->updated_by = $created_by;
            $update->save();
            DB::commit();
            return response()->json(['status' => 'success'], 200);
        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Update Driver Record'], 422);
        }
    }

    public function destroy($id)
    {
        $driver = Driver::find($id); //QUERY DATA BERDASARKAN ID
        $driver->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }



}
