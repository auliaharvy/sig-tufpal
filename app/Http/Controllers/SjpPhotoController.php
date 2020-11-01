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


        $sjp = DB::table('surat_jalan_pallet as a')
        ->join(DB::raw('(SELECT * FROM sjp_pallet_send )b'),
            function($join){
                $join->on('a.sjp_number','=','b.sjp_number');
            })
        ->join(DB::raw('(SELECT * FROM sjp_pallet_receive )c'),
            function($join){
                $join->on('a.sjp_number','=','c.sjp_number');
            })
        ->select('a.sjp_number', 'b.sender', 'b.departure_pool', 'b.destination_pool', 'b.sending_driver_approval', 'c.receiver', 'c.receiving_driver_approval',)
        ->whereBetween('a.created_at',[$dateS,$dateE])
        ->paginate(1000000)
        ->toArray();
        return $sjp;
    }

}
