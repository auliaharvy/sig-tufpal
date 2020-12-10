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
    public function index()
    {
        $dateS = Carbon::now()->startOfMonth()->subMonth(3);
        $dateE = Carbon::now()->startOfMonth(); 


        $sjp = DB::table('all_transaction as a')
        ->where('a.reference_sjp_id', '!=', null )
        ->join(DB::raw('(SELECT * FROM surat_jalan_pallet )b'),
            function($join){
                $join->on('a.reference_sjp_id','=','b.sjp_id');
            })
        ->select('a.*', 'b.sjp_number')
        // ->whereBetween('a.created_at',[$dateS,$dateE])
        ->paginate(1000000)
        ->toArray();
        return $sjp;
    }

}
