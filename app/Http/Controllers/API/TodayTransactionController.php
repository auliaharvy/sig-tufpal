<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Carbon\Carbon;
use App\Transaction;
use App\Alltransaction;
use App\PoolPallet;
use App\Transporter;
use App\Sjppalletsend;
use App\Sjppalletreceive;
use App\Newpallet;
use App\Pallettransfersend;
use App\Pallettransferreceive;
use App\Sjp;
use DB;
use Excel;
use Mail;
use App\Exports\TodayTransactionExport;

class TodayTransactionController extends Controller
{
   

    public function allTransactionToday()
    {
        $alltransactiontoday = DB::table('all_transaction as a')
        // ->orderBy('created_at', 'DESC')
        ->leftJoin('surat_jalan_pallet as b', 'a.reference_sjp_id', '=', 'b.sjp_id')
        ->leftJoin('sjp_status as c', 'a.reference_sjp_status_id', '=', 'c.sjp_status_id')
        ->leftJoin('pallet_transfer as d', 'a.reference_pallet_transfer_id', '=', 'd.pallet_transfer_id')
        ->leftJoin('ber_missing_pallet as e', 'a.reference_ber_missing_id', '=', 'e.ber_missing_pallet_id')
        ->leftJoin('new_pallet as f', 'a.reference_new_pallet_id', '=', 'f.new_pallet_id')
        ->leftJoin('damaged_pallet as g', 'a.reference_damaged_pallet_id', '=', 'g.damaged_pallet_id')
        ->leftJoin('repaired_pallet as h', 'a.reference_repaired_pallet_id', '=', 'h.repaired_pallet_id')
        ->select('a.*', 'b.sjp_number', 'c.sjps_number', 'd.tp_number',
                'e.bmp_number', 'f.np_number', 'g.dp_number', 'h.rp_number')
        ->whereDate('a.created_at', '=', Carbon::today()->toDateString())
        ->latest()
        ->get();
    
        return $alltransactiontoday;
    }

    public function exportData(Request $request)
    {
        
        $now = Carbon::today()->toDateString();
        $alltransactiontoday = $this->allTransactionToday();
        return Excel::download(new TodayTransactionExport($alltransactiontoday),  $now .' ' .'Transaction.xlsx');
    }

    public function storeData(Request $request)
    {
        
        $now = Carbon::today()->toDateString();
        $alltransactiontoday = $this->allTransactionToday();
        return Excel::store(new TodayTransactionExport($alltransactiontoday),  $now .' ' .'Transaction.xlsx');
    }

    public function attachment_email() 
    {
        $now = Carbon::today()->toDateString();
        $filename = $now .'-'.'Transaction.xlsx';
        $alltransactiontoday = $this->allTransactionToday();
        $disk = 'local';
        $excelFile = \Excel::store(new TodayTransactionExport($alltransactiontoday),  $filename, $disk);
        $fullPath = \Storage::disk($disk)->path($filename);
      
        // $attacment = Excel::download(new TodayTransactionExport($alltransactiontoday),  $now .' ' .'Transaction.xlsx');
        $data = array('name'=>"Tufpal System");
        Mail::send('mail', $data, function($message) use($fullPath) {
           $message->to('triyatmo@indocement.co.id', 'Indocement')->subject
              ('Tufpal One Day Transaction');
           $message->attach($fullPath);
           $message->from('tufpalsystem@gmail.com','Tufpal System');
        });
        \File::Delete( $fullPath);
        echo "Email Sent with attachment. Check your inbox.";
     }
}
