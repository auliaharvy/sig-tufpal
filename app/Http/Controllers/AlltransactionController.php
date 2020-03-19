<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\Sjppalletsend;
use App\Sjppalletreceive;
use App\Sjpadjusment;
use App\Sjpchangedestination;
use App\pallettransfersend;
use App\pallettransferreceive;
use App\Bermissingreported;
use App\Bermissingapproved;
use App\Bermissingdisapproved;
use App\Damagedpallet;
use App\Repairedpallet;
use DB;

class AlltransactionController extends Controller
{
    public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        if($pool_pallet==1 && $role<7){
        $alltransaction = DB::table('sjp_pallet_send as a')
                ->join('sjp_pallet_receive as b', '=', 'b.sjp_number')
                ->join('sjp_adjusment as c', '=', 'c.sa_number')
                ->join('sjp_change_destination as d', '=', 'd.scd_number')
                ->join('pallet_transfer_send_pallet as e','=', 'e.tp_number')
                ->join('pallet_transfer_receive_pallet as f','=', 'f.tp_number')
                ->join('ber_missing_pallet_reported as g','=', 'g.bmp_number')
                ->join('ber_missing_pallet_approved as h','=', 'h.bmp_number')
                ->join('ber_missing_pallet_disapproved as i','=', 'h.bmp_number')
                ->join('damaged_pallet as j','=', 'j.dp_number')
                ->join('repaired_pallet as k','=', 'k.rp_number')
                ->select('a.sjp_number as transaction_code',
                         'b.sjp_number as transaction_code',
                         'c.sa_number as transaction_code',
                         'd.scd_number as transaction_code',
                         'e.tp_number as transaction_code',
                         'f.tp_number as transaction_code',
                         'g.bmp_number as transaction_code',
                         'h.bmp_number as transaction_code',
                         'i.bmp_number as transaction_code',
                         'j.dp_number as transaction_code',
                         'k.rp_number as transaction_code')
                ->paginate(1000000)
                ->toArray();
        }
        else{
            $alltransaction = DB::table('sjp_pallet_send as a')
                ->join('sjp_pallet_receive as b', '=', 'b.sjp_number')
                ->join('sjp_adjusment as c', '=', 'c.sa_number')
                ->join('sjp_change_destination as d', '=', 'd.scd_number')
                ->join('pallet_transfer_send_pallet as e','=', 'e.tp_number')
                ->join('pallet_transfer_receive_pallet as f','=', 'f.tp_number')
                ->join('ber_missing_pallet_reported as g','=', 'g.bmp_number')
                ->join('ber_missing_pallet_approved as h','=', 'h.bmp_number')
                ->join('ber_missing_pallet_disapproved as i','=', 'h.bmp_number')
                ->join('damaged_pallet as j','=', 'j.dp_number')
                ->join('repaired_pallet as k','=', 'k.rp_number')
                ->select('a.sjp_number as transaction_code',
                        'b.sjp_number as transaction_code',
                        'c.sa_number as transaction_code',
                        'd.scd_number as transaction_code',
                        'e.tp_number as transaction_code',
                        'f.tp_number as transaction_code',
                        'g.bmp_number as transaction_code',
                        'h.bmp_number as transaction_code',
                        'i.bmp_number as transaction_code',
                        'j.dp_number as transaction_code',
                        'k.rp_number as transaction_code')
                ->paginate(1000000)
                ->toArray();
        }
       
        // // $sjp = new SjpCollection($sjp1);
        return $alltransaction;
        // $sjpstatus = new SjpStatusCollection(SjpStatus::paginate(10));
		//  return $sjpstatus;
        // return response()->json(Sjp::all()->toArray());
    }
}