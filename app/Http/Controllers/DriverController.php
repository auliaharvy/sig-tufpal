<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use App\Driver;
use DB;

class DriverController extends Controller
{
    public function index()
    {
        $driver = new SjpStatusCollection(Driver::paginate(100000));
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

    

}
