<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjppalletsendCollection;
use App\Sjppalletsend;
use App\Sjppalletreceive;
use Carbon\Carbon;
use App\Sjp;
use DB;

class SjpPhotoController extends Controller
{
    public function index(Request $request)
    {
        $filter = request()->year . '-' . request()->month;
        $parse = Carbon::parse($filter);


        $sjp = DB::table('all_transaction as a')
        ->where('a.created_at', 'LIKE', '%' . $filter . '%')
        ->where('a.reference_sjp_id', '!=', null )
        ->where('a.sending_driver_approval', '!=', null )
        ->orWhere('a.receiving_driver_approval', '!=', null )
        ->join(DB::raw('(SELECT * FROM surat_jalan_pallet )b'),
            function($join){
                $join->on('a.reference_sjp_id','=','b.sjp_id');
            })
        ->select('a.*', 'b.sjp_number')
        // ->whereBetween( 'a.created_at', [ $fromDate . ' 00:01:00', $toDate . ' 23:59:59'])
        // ->whereBetween('a.created_at',[$dateS,$dateE])
        ->paginate(1000000)
        ->toArray();
        return $sjp;
    }

}
