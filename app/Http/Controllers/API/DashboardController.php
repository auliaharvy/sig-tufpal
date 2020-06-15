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
use App\Exports\TransactionExport;

class DashboardController extends Controller
{
    public function chart() //grafik send & receive
    {
        $filter = request()->year . '-' . request()->month;
        $parse = Carbon::parse($filter);
        $array_date = range($parse->startOfMonth()->format('d'), $parse->endOfMonth()->format('d'));
        $transaction = Sjppalletsend::select(DB::raw('date(created_at) as date,sum(good_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
            ->where('created_at', 'LIKE', '%' . $filter . '%')
            ->where('sjp_status', '=', "SEND")
            ->groupBy(DB::raw('date(created_at)'))->get();
        $transactionreceive = Sjppalletreceive::select(DB::raw('date(created_at) as date,sum(good_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
            ->where('created_at', 'LIKE', '%' . $filter . '%')
            ->where('sjp_status', '=', "RECEIVE")
            ->groupBy(DB::raw('date(created_at)'))->get();

        $data = [];
        foreach ($array_date as $row) {
            $f_date = strlen($row) == 1 ? 0 . $row:$row;
            $date = $filter . '-' . $f_date;
            $total = $transaction->firstWhere('date', $date);
            $totalreceive = $transactionreceive->firstWhere('date', $date);

            $data[] = [
                'date' =>$date,
                'total' => $total ? $total->total:0,
                'totalreceive' => $totalreceive ? $totalreceive->total:0
            ];
        }
        return $data;
    }

    public function chart2() //grafik sendback & receive sendback
    {
        $filter = request()->year . '-' . request()->month;
        $parse = Carbon::parse($filter);
        $array_date = range($parse->startOfMonth()->format('d'), $parse->endOfMonth()->format('d'));
        $transaction = Sjppalletsend::select(DB::raw('date(created_at) as date,sum(good_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
            ->where('created_at', 'LIKE', '%' . $filter . '%')
            ->where('sjp_status', '=', "SEND BACK")
            ->groupBy(DB::raw('date(created_at)'))->get();
        $transactionreceive = Sjppalletreceive::select(DB::raw('date(created_at) as date,sum(good_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
            ->where('created_at', 'LIKE', '%' . $filter . '%')
            ->where('sjp_status', '=', "RECEIVE SENDBACK")
            ->groupBy(DB::raw('date(created_at)'))->get();

        $data = [];
        foreach ($array_date as $row) {
            $f_date = strlen($row) == 1 ? 0 . $row:$row;
            $date = $filter . '-' . $f_date;
            $total = $transaction->firstWhere('date', $date);
            $totalreceive = $transactionreceive->firstWhere('date', $date);

            $data[] = [
                'date' =>$date,
                'total' => $total ? $total->total:0,
                'totalreceive' => $totalreceive ? $totalreceive->total:0
            ];
        }
        return $data;
    }

    public function globalpallet() //grafik all pallet
    {
        $poolTotal = PoolPallet::select(DB::raw('type,sum(good_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('type'))
        ->get()
        ->toArray();
        $transporterTotal = Transporter::select(DB::raw('tag as type,sum(good_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('type'))
        ->get()
        ->toArray();

        $total = array_merge($poolTotal,$transporterTotal);

        return $total;
    }

    public function pallet() // grafik pool pallet status
    {
        $goodTotal = PoolPallet::select(DB::raw('sum(good_pallet) as total'))
        // ->groupBy(DB::raw('tag'))
        ->get()
        ->toArray();
        $tbrTotal = PoolPallet::select(DB::raw('sum(tbr_pallet) as total'))
        // ->groupBy(DB::raw('tag'))
        ->get()
        ->toArray();
        $berTotal = PoolPallet::select(DB::raw('sum(ber_pallet) as total'))
        // ->groupBy(DB::raw('tag'))
        ->get()
        ->toArray();
        $missingTotal = PoolPallet::select(DB::raw('sum(missing_pallet) as total'))
        // ->groupBy(DB::raw('tag'))
        ->get()
        ->toArray();

        $total = array_merge($goodTotal,$tbrTotal,$berTotal,$missingTotal);

        return $total;
    }

    public function palletTransporter() // grafik transporter pallet status
    {
        $goodTotal = Transporter::select(DB::raw('sum(good_pallet) as total'))
        // ->groupBy(DB::raw('tag'))
        ->get()
        ->toArray();
        $tbrTotal = Transporter::select(DB::raw('sum(tbr_pallet) as total'))
        // ->groupBy(DB::raw('tag'))
        ->get()
        ->toArray();
        $berTotal = Transporter::select(DB::raw('sum(ber_pallet) as total'))
        // ->groupBy(DB::raw('tag'))
        ->get()
        ->toArray();
        $missingTotal = Transporter::select(DB::raw('sum(missing_pallet) as total'))
        // ->groupBy(DB::raw('tag'))
        ->get()
        ->toArray();

        $total = array_merge($goodTotal,$tbrTotal,$berTotal,$missingTotal);

        return $total;
    }

    public function poolPalletDetail() //grafik warehouse detail
    {
        $poolDetail = PoolPallet::select(DB::raw('pool_name,sum(good_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('pool_name'))
        ->where(DB::raw('good_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        ->where('type', '=' , "WAREHOUSE")
        ->get()
        ->toArray();

        return $poolDetail;
    }

    public function transporterDetail() //grafik transporter detail
    {
        $transporterDetail = Transporter::select(DB::raw('transporter_name,sum(good_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('transporter_name'))
        ->where(DB::raw('good_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        ->get()
        ->toArray();

        return $transporterDetail;
    }

    public function totalAllPallet() //total all pallet
    {
        $poolTotal = PoolPallet::select(DB::raw('type, sum(good_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('type'))
        ->get()
        ->toArray();
        $transporterTotal = Transporter::select(DB::raw('tag as type, sum(good_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('type'))
        ->get()
        ->toArray();

        $total = array_merge($poolTotal, $transporterTotal);

        $sum = 0;
        foreach ($total as $item) {
            $sum += $item['total'];
        }

        return $sum;
    }

    public function detailPoolPallet() //Grafik Pallet Status (Good, TBR, BER, Missing) di Warehouse
    {
        $poolName = request()->pool_name;
            $goodTotal = PoolPallet::select(DB::raw('sum(good_pallet) as total'))
            ->where('pool_name', '=', "$poolName")
            ->get()
            ->toArray();
            $tbrTotal = PoolPallet::select(DB::raw('sum(tbr_pallet) as total'))
            ->where('pool_name', '=', "$poolName")
            ->get()
            ->toArray();
            $berTotal = PoolPallet::select(DB::raw('sum(ber_pallet) as total'))
            ->where('pool_name', '=', "$poolName")
            ->get()
            ->toArray();
            $missingTotal = PoolPallet::select(DB::raw('sum(missing_pallet) as total'))
            ->where('pool_name', '=', "$poolName")
            ->get()
            ->toArray();        

            $total = array_merge($goodTotal,$tbrTotal,$berTotal,$missingTotal);

        return $total;
    }

    public function detailTransporter() //Grafik Pallet Status (Good, TBR, BER, Missing) di Transporter
    {
        $transporterName = request()->transporter_name;
            $goodTotal = Transporter::select(DB::raw('sum(good_pallet) as total'))
            ->where('transporter_name', '=', "$transporterName")
            ->get()
            ->toArray();
            $tbrTotal = Transporter::select(DB::raw('sum(tbr_pallet) as total'))
            ->where('transporter_name', '=', "$transporterName")
            ->get()
            ->toArray();
            $berTotal = Transporter::select(DB::raw('sum(ber_pallet) as total'))
            ->where('transporter_name', '=', "$transporterName")
            ->get()
            ->toArray();
            $missingTotal = Transporter::select(DB::raw('sum(missing_pallet) as total'))
            ->where('transporter_name', '=', "$transporterName")
            ->get()
            ->toArray();        

            $total = array_merge($goodTotal,$tbrTotal,$berTotal,$missingTotal);

        return $total;
    }

    public function workshopInOut() //grafik New Pallet, TBR in to workshop, Good Pallet out from workshop
    {
        $newPallet = Newpallet::select(DB::raw(' concat("New Pallet From " ,vendor) as label ,sum(good_pallet) as total'))
        ->groupBy(DB::raw('vendor'))
        // ->where(DB::raw('good_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        ->get()
        ->toArray();

        $tbrReceive = Pallettransferreceive::select(DB::raw(' concat("TBR Pallet Receive " ,destination_pool) as label ,sum(tbr_pallet) as total'))
        ->groupBy(DB::raw('destination_pool'))
        ->where('destination_pool',  '=', "Workshop DLI")
        ->get()
        ->toArray();

        $goodSend = Pallettransfersend::select(DB::raw(' concat("Good Pallet Send " ,departure_pool) as label ,sum(good_pallet) as total'))
        ->groupBy(DB::raw('departure_pool'))
        ->where('departure_pool',  '=', "Workshop DLI")
        ->get()
        ->toArray();



        $total = array_merge($newPallet,$tbrReceive,$goodSend);

        return $total;
    }

    public function transporterToPool() //grafik Transporter send to pool
    {
        $transporterName = request()->transporter;
        $transporter = Transporter::where('transporter_name', '=', $transporterName)->firstOrFail();
        $transporterId = $transporter->transporter_code;
        $sjp = Sjp::where('transporter_id', '=', $transporterId)
        ->where('status', "OPEN")
        ->where('is_sendback', 0)
        ->get();

                
        // $poolId = [$sjp->destination_pool_pallet_id];
        // $poolName = PoolPallet::where('pool_name',)

        // $newPallet = Newpallet::select(DB::raw(' destination_pool as label ,sum(good_pallet + tbr_pallet + ber_pallet + missing_pallet ) as total'))
        // ->groupBy(DB::raw('vendor'))
        // // ->where(DB::raw('good_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        // ->get()
        // ->toArray();

        // $tbrReceive = Pallettransferreceive::select(DB::raw(' concat("TBR Pallet Receive " ,destination_pool) as label ,sum(tbr_pallet) as total'))
        // ->groupBy(DB::raw('destination_pool'))
        // ->where('destination_pool',  '=', "Workshop DLI")
        // ->get()
        // ->toArray();

        // $goodSend = Pallettransfersend::select(DB::raw(' concat("Good Pallet Send " ,departure_pool) as label ,sum(good_pallet) as total'))
        // ->groupBy(DB::raw('departure_pool'))
        // ->where('departure_pool',  '=', "Workshop DLI")
        // ->get()
        // ->toArray();



        // $total = array_merge($newPallet,$tbrReceive,$goodSend);

        return $sjp;
    }

    public function exportData(Request $request)
    {
        $transaction = $this->chart();
        return Excel::download(new TransactionExport($transaction, request()->month, request()->year), 'transaction.xlsx');
    }
}
