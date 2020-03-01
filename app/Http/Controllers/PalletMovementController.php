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
        
        $palletmovement = DB::table('sjp_status as a')
                // ->join('users as b', 'a.checker_send_user_id', '=', 'b.id')
                // ->join('users as c', 'a.checker_receive_user_id', '=', 'c.id')
                ->join('surat_jalan_pallet as d', 'a.sjp_id', '=', 'd.sjp_id')
                ->join('pool_pallet as b', 'd.destination_pool_pallet_id', '=', 'b.pool_pallet_id')
                ->join('pool_pallet as c', 'd.departure_pool_pallet_id', '=', 'c.pool_pallet_id')
                ->join('mst_transaction as e', 'a.transaction_id', '=', 'e.id')
                ->select('a.*','d.sjp_number','e.transaction','b.pool_name as dest_pool', 'c.pool_name as dept_pool','d.pallet_quantity','d.departure_time','d.eta')            
                ->paginate(15)
                ->toArray();
       
        // // $sjp = new SjpCollection($sjp1);
        return $palletmovement;
        // $sjpstatus = new SjpStatusCollection(SjpStatus::paginate(10));
		//  return $sjpstatus;
        // return response()->json(Sjp::all()->toArray());
    }
}
