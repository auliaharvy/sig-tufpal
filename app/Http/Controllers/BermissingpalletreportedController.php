<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\BermissingpalletreportedCollection;
use Illuminate\Support\Facades\Auth;
use App\Bermissing;
use App\Bermissingreported;
use DB;

class BermissingpalletreportedController extends Controller
{
    public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        if($pool_pallet==1 && $role<7){
            $bermissingreported = DB::table('ber_missing_pallet_reported as a')
                ->join('ber_missing_pallet as b','a.ber_missing_id', '=', 'b.ber_missing_pallet_id')
                ->select('a.*','b.bmp_number')
                ->paginate(1000000)
                ->toArray();
        }
        else{
            $bermissingreported = DB::table('ber_missing_pallet_reported as a')
                ->join('ber_missing_pallet as b','a.ber_missing_id', '=', 'b.ber_missing_pallet_id')
                ->select('a.*','b.bmp_number')
                ->paginate(1000000)
                ->toArray();
        }
        // // $sjp = new SjpCollection($sjp1);
        return $bermissingreported;
        // $sjpstatus = new SjpStatusCollection(SjpStatus::paginate(10));
		//  return $sjpstatus;
        // return response()->json(Sjp::all()->toArray());
    }
}
