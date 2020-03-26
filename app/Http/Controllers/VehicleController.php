<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use App\Vehicle;
use DB;

class VehicleController extends Controller
{
    public function index()
    {
        $vehicle = new SjpStatusCollection(Vehicle::paginate(10));
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
    

}
