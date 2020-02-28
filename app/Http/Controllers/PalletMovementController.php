<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\SjpStatus;
use App\Sjp;
use App\PoolPallet;
use App\Transporter;
use App\Bermissing;
use DB;

class PalletMovementController extends Controller
{
    public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        if($pool_pallet==null){
        $palletmovement = DB::table('surat_jalan_pallet as a')
            // ->join('users as b', 'a.checker_send_user_id', '=', 'b.id')
            // ->join('users as c', 'a.checker_receive_user_id', '=', 'c.id')
            ->join('pool_pallet as c', 'a.departure_pool_pallet_id', '=', 'c.pool_pallet_id')
            ->join('pool_pallet as d', 'a.destination_pool_pallet_id', '=', 'd.pool_pallet_id')
            ->join('surat_jalan_pallet as e', 'a.sjp_id', '=', 'e.sjp_id')
            ->select('a.*', 'c.pool_name as dept_pool', 'd.pool_name as dest_pool'
                    ,'e.sjp_number')            
            ->paginate(10)
            ->toArray();
        }
        else{
            $palletmovement = DB::table('surat_jalan_pallet as a', 'sjp_status as b')
            // ->join('users as b', 'a.checker_send_user_id', '=', 'b.id')
            // ->join('users as c', 'a.checker_receive_user_id', '=', 'c.id')
            ->join('pool_pallet as c', 'a.departure_pool_pallet_id', '=', 'c.pool_pallet_id')
            ->join('pool_pallet as d', 'a.destination_pool_pallet_id', '=', 'd.pool_pallet_id')
            ->join('surat_jalan_pallet as e', 'a.sjp_id', '=', 'e.sjp_id')
            ->select('a.*', 'b.*', 'c.pool_name as dept_pool', 'd.pool_name as dest_pool'
                    ,'e.sjp_number') 
            ->where('d.departure_pool_pallet_id',$pool_pallet)
            ->orWhere('d.destination_pool_pallet_id', $pool_pallet)
            
            ->paginate(10)
            ->toArray();
        }
        // // $sjp = new SjpCollection($sjp1);
        return $palletmovement;
        // $sjpstatus = new SjpStatusCollection(SjpStatus::paginate(10));
		//  return $sjpstatus;
        // return response()->json(Sjp::all()->toArray());
    }
}
