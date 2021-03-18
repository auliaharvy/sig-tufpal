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
use App\SjpStatus;
use DB;
use Excel;
use App\Exports\TransactionExport;

class DashboardController extends Controller
{
    public function tonnaseOut() //grafik send & receive
    {
        $filter = request()->year . '-' . request()->month;
        $parse = Carbon::parse($filter);
        $array_date = range($parse->startOfMonth()->format('d'), $parse->endOfMonth()->format('d'));
        $transaction = Sjp::select(DB::raw('date(created_at) as date, sum(tonnage) as tonnase'))
        ->where('departure_pool_pallet_id', '=', 'pooldli')
        ->where('created_at', 'LIKE', '%' . $filter . '%')
        ->where('status', '!=', 'DRAFT')
        ->where('distribution', '=', 0)
        ->groupBy(DB::raw('date(created_at)'))->get();
        // $transaction = Sjppalletsend::select(DB::raw('date(created_at) as date, floor(sum((good_pallet*2000/good_cement)*good_cement/1000)) as tonnase'))
        //     ->where('created_at', 'LIKE', '%' . $filter . '%')
        //     ->where('sjp_status', '=', "SEND")
        //     ->groupBy(DB::raw('date(created_at)'))->get();

        $data = [];
        foreach ($array_date as $row) {
            $f_date = strlen($row) == 1 ? 0 . $row:$row;
            $date = $filter . '-' . $f_date;
            $tonnase = $transaction->firstWhere('date', $date);
            // round($tonnase);

            $data[] = [
                'date' =>$date,
                'tonnase' => $tonnase ? $tonnase->tonnase:0,
                // 'tonnase' => $good_cement ? $good_cement->good_cement:0,
            ];
        }
        return $data;
    }
    public function tonnaseOut_1() //grafik send & receive
    {
        $filter = request()->year . '-' . request()->month;
        $parse = Carbon::parse($filter);
        $array_date = range($parse->startOfMonth()->format('d'), $parse->endOfMonth()->format('d'));
        $transaction = Sjp::select(DB::raw('date(created_at) as date, sum(tonnage) as tonnase'))
        ->where('departure_pool_pallet_id', '=', 'bayah')
        ->where('created_at', 'LIKE', '%' . $filter . '%')
        ->where('status', '!=', 'DRAFT')
        ->where('distribution', '=', 0)
        ->groupBy(DB::raw('date(created_at)'))->get();
        // $transaction = Sjppalletsend::select(DB::raw('date(created_at) as date, floor(sum((good_pallet*2000/good_cement)*good_cement/1000)) as tonnase'))
        //     ->where('created_at', 'LIKE', '%' . $filter . '%')
        //     ->where('sjp_status', '=', "SEND")
        //     ->groupBy(DB::raw('date(created_at)'))->get();

        $data = [];
        foreach ($array_date as $row) {
            $f_date = strlen($row) == 1 ? 0 . $row:$row;
            $date = $filter . '-' . $f_date;
            $tonnase = $transaction->firstWhere('date', $date);
            // round($tonnase);

            $data[] = [
                'date' =>$date,
                'tonnase' => $tonnase ? $tonnase->tonnase:0,
                // 'tonnase' => $good_cement ? $good_cement->good_cement:0,
            ];
        }
        return $data;
    }
    public function chart() //grafik send & receive
    {
        $filter = request()->year . '-' . request()->month;
        $parse = Carbon::parse($filter);
        $array_date = range($parse->startOfMonth()->format('d'), $parse->endOfMonth()->format('d'));
        $transaction = Sjppalletsend::select(DB::raw('date(created_at) as date,sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
            ->where('created_at', 'LIKE', '%' . $filter . '%')
            ->where('sjp_status', '=', "SEND")
            ->groupBy(DB::raw('date(created_at)'))->get();
        $transactionreceive = Sjppalletreceive::select(DB::raw('date(created_at) as date,sum(good_pallet + filled_pallet+ tbr_pallet + ber_pallet + missing_pallet) as total'))
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
        $transaction = Sjppalletsend::select(DB::raw('date(created_at) as date,sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
            ->where('created_at', 'LIKE', '%' . $filter . '%')
            ->where('sjp_status', '=', "SEND BACK")
            ->groupBy(DB::raw('date(created_at)'))->get();
        $transactionreceive = Sjppalletreceive::select(DB::raw('date(created_at) as date,sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
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
        $poolTotal = PoolPallet::select(DB::raw('type,sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('type'))
        ->get()
        ->toArray();
        $transporterTotal = Transporter::select(DB::raw('tag as type,sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
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
        $filledTotal = PoolPallet::select(DB::raw('sum(filled_pallet) as total'))
        // ->groupBy(DB::raw('tag'))
        ->get()
        ->toArray();

        $total = array_merge($goodTotal,$tbrTotal,$berTotal,$missingTotal,$filledTotal);

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
        $filledTotal = Transporter::select(DB::raw('sum(filled_pallet) as total'))
        // ->groupBy(DB::raw('tag'))
        ->get()
        ->toArray();

        $total = array_merge($goodTotal,$tbrTotal,$berTotal,$missingTotal,$filledTotal);

        return $total;
    }

    public function pool_dli_in_out() //grafik warehouse detail
    {
        $poolDetail = PoolPallet::select(DB::raw('pool_name'))
        ->groupBy(DB::raw('pool_name'))
        ->where(DB::raw('good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        ->where('type', '=' , "POOL_PALLET_DLI")
        ->get();
        $poolStock = PoolPallet::select(DB::raw('pool_name,sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('pool_name'))
        ->where(DB::raw('good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        ->where('type', '=' , "POOL_PALLET_DLI")
        ->get();
        $palletIn = DB::table('surat_jalan_pallet as a')
        ->join('sjp_status as b', 'a.sjp_id', '=', 'b.sjp_id')
        ->join('pool_pallet as c', 'a.departure_pool_pallet_id', '=', 'c.pool_pallet_id')
        ->where('a.state', 1)
        ->where('b.status', 0)
        ->select('a.departure_pool_pallet_id', 'c.pool_name', 'a.state as state_in', DB::raw('SUM(b.good_pallet + b.filled_pallet + b.tbr_pallet + b.ber_pallet + b.missing_pallet) as pallet_in'))
        ->groupBy('c.pool_name')
        ->get();
        $palletOut = DB::table('surat_jalan_pallet as a')
        ->join('sjp_status as b', 'a.sjp_id', '=', 'b.sjp_id')
        ->join('pool_pallet as c', 'a.departure_pool_pallet_id', '=', 'c.pool_pallet_id')
        ->where('a.state', 3)
        ->where('b.status', 0)
        ->select('a.departure_pool_pallet_id', 'c.pool_name', 'a.state as state_out' ,DB::raw('SUM(b.good_pallet + b.filled_pallet + b.tbr_pallet + b.ber_pallet + b.missing_pallet) as pallet_out'))
        ->groupBy('c.pool_name')
        ->get();

        $data = [];
        foreach ($poolDetail as $row) {
            $pool_name = $row->pool_name;
            $stock = $poolStock->firstWhere('pool_name', $pool_name);
            $pallet_in = $palletIn->firstWhere('pool_name', $pool_name);
            $pallet_out = $palletOut->firstWhere('pool_name', $pool_name);

            $data[] = [
                'pool_name' => $pool_name,
                'stock' => $stock ? $stock->total:0,
                'pallet_in' => $pallet_in ? $pallet_in->pallet_in:0,
                'pallet_out' => $pallet_out ? $pallet_out->pallet_out:0
            ];
        }
        return $data;
    }

    public function poolPalletDetail() //grafik warehouse detail
    {
        $poolDetail = PoolPallet::select(DB::raw('pool_name,sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('pool_name'))
        ->where(DB::raw('good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        ->where('type', '=' , "WAREHOUSE")
        ->get()
        ->toArray();
        $palletIn = DB::table('sjp_status as a')
        ->join('surat_jalan_pallet as b', 'a.sjp_id', '=', 'b.sjp_id')
        ->join('pool_pallet as c', 'b.destination_pool_pallet_id', '=', 'c.pool_pallet_id')
        ->select('c.pool_name', DB::raw('sum(a.good_pallet + a.filled_pallet + a.tbr_pallet + a.ber_pallet + a.missing_pallet) as pallet_in') )
        ->groupBy('c.pool_name')
        ->where('a.transaction_id', 1)
        ->where('a.status', 0)
        ->get()
        ->toArray();
        $palletOut = DB::table('sjp_status as a')
        ->join('surat_jalan_pallet as b', 'a.sjp_id', '=', 'b.sjp_id')
        ->join('pool_pallet as c', 'b.destination_pool_pallet_id', '=', 'c.pool_pallet_id')
        ->select('c.pool_name', DB::raw('sum(a.good_pallet + a.filled_pallet + a.tbr_pallet + a.ber_pallet + a.missing_pallet) as pallet_out') )
        ->groupBy('c.pool_name')
        ->where('a.transaction_id', 2)
        ->where('a.status', 0)
        ->get()
        ->toArray();

        return $poolDetail;
    }

    public function warehouse_in_out() //grafik warehouse in_out
    {
        $poolDetail = PoolPallet::select(DB::raw('pool_name'))
        ->groupBy(DB::raw('pool_name'))
        ->where(DB::raw('good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        ->where('type', '=' , "WAREHOUSE")
        ->get();
        $poolStock = PoolPallet::select(DB::raw('pool_name,sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('pool_name'))
        ->where(DB::raw('good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        ->where('type', '=' , "WAREHOUSE")
        ->get();
        $palletIn = DB::table('surat_jalan_pallet as a')
        ->join('sjp_status as b', 'a.sjp_id', '=', 'b.sjp_id')
        ->join('pool_pallet as c', 'a.destination_pool_pallet_id', '=', 'c.pool_pallet_id')
        ->where('a.state', 1)
        ->where('b.status', 0)
        ->select('a.departure_pool_pallet_id', 'c.pool_name', 'a.state as state_in', DB::raw('SUM(b.good_pallet + b.filled_pallet + b.tbr_pallet + b.ber_pallet + b.missing_pallet) as pallet_in'))
        ->groupBy('c.pool_name')
        ->get();
        $palletOut = DB::table('surat_jalan_pallet as a')
        ->join('sjp_status as b', 'a.sjp_id', '=', 'b.sjp_id')
        ->join('pool_pallet as c', 'a.destination_pool_pallet_id', '=', 'c.pool_pallet_id')
        ->where('a.state', 3)
        ->where('b.status', 0)
        ->select('a.departure_pool_pallet_id', 'c.pool_name', 'a.state as state_out' ,DB::raw('SUM(b.good_pallet + b.filled_pallet + b.tbr_pallet + b.ber_pallet + b.missing_pallet) as pallet_out'))
        ->groupBy('c.pool_name')
        ->get();

        $data = [];
        foreach ($poolDetail as $row) {
            $pool_name = $row->pool_name;
            $stock = $poolStock->firstWhere('pool_name', $pool_name);
            $pallet_in = $palletIn->firstWhere('pool_name', $pool_name);
            $pallet_out = $palletOut->firstWhere('pool_name', $pool_name);

            $data[] = [
                'pool_name' => $pool_name,
                'stock' => $stock ? $stock->total:0,
                'pallet_in' => $pallet_in ? $pallet_in->pallet_in:0,
                'pallet_out' => $pallet_out ? $pallet_out->pallet_out:0
            ];
        }
        return $data;
    }
    public function transporterSendSendback() //grafik warehouse in_out
    {
        $transporterDetail = Transporter::select(DB::raw('transporter_name'))
        ->groupBy(DB::raw('transporter_name'))
        ->where(DB::raw('good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        ->get();
        $transporterStock = Transporter::select(DB::raw('transporter_name,sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('transporter_name'))
        ->where(DB::raw('good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        ->get();
        $palletSend = DB::table('surat_jalan_pallet as a')
        ->join('sjp_status as b', 'a.sjp_id', '=', 'b.sjp_id')
        ->join('transporter as c', 'a.transporter_id', '=', 'c.transporter_id')
        ->where('a.state', 1)
        ->where('b.status', 0)
        ->select('a.transporter_id', 'c.transporter_name', 'a.state as state_in', DB::raw('SUM(b.good_pallet + b.filled_pallet + b.tbr_pallet + b.ber_pallet + b.missing_pallet) as pallet_send'))
        ->groupBy('c.transporter_name')
        ->get();
        $palletSendback = DB::table('surat_jalan_pallet as a')
        ->join('sjp_status as b', 'a.sjp_id', '=', 'b.sjp_id')
        ->join('transporter as c', 'a.transporter_id', '=', 'c.transporter_id')
        ->where('a.state', 3)
        ->where('b.status', 0)
        ->select('a.transporter_id', 'c.transporter_name', 'a.state as state_out' ,DB::raw('SUM(b.good_pallet + b.filled_pallet + b.tbr_pallet + b.ber_pallet + b.missing_pallet) as pallet_sendback'))
        ->groupBy('c.transporter_name')
        ->get();

        $data = [];
        foreach ($transporterDetail as $row) {
            $transporter_name = $row->transporter_name;
            $stock = $transporterStock->firstWhere('transporter_name', $transporter_name);
            $pallet_send = $palletSend->firstWhere('transporter_name', $transporter_name);
            $pallet_sendback = $palletSendback->firstWhere('transporter_name', $transporter_name);

            $data[] = [
                'transporter_name' => $transporter_name,
                'stock' => $stock ? $stock->total:0,
                'pallet_send' => $pallet_send ? $pallet_send->pallet_send:0,
                'pallet_sendback' => $pallet_sendback ? $pallet_sendback->pallet_sendback:0
            ];
        }
        return $data;
    }

    public function transporterDetail() //grafik transporter detail
    {
        $transporterDetail = Transporter::select(DB::raw('transporter_name,sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('transporter_name'))
        ->where(DB::raw('good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet') ,  '!=', 0)
        ->get()
        ->toArray();

        return $transporterDetail;
    }

    public function totalAllPallet() //total all pallet
    {
        $poolTotal = PoolPallet::select(DB::raw('type, sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
        ->groupBy(DB::raw('type'))
        ->get()
        ->toArray();
        $transporterTotal = Transporter::select(DB::raw('tag as type, sum(good_pallet + filled_pallet + tbr_pallet + ber_pallet + missing_pallet) as total'))
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

    public function detailPoolPalletDli() //Grafik Pallet Status (Good, TBR, BER, Missing) di Warehouse
    {
        $poolName = request()->detail_pool_dli_name;
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
            $filledTotal = PoolPallet::select(DB::raw('sum(filled_pallet) as total'))
            ->where('pool_name', '=', "$poolName")
            ->get()
            ->toArray();     

            $total = array_merge($goodTotal,$tbrTotal,$berTotal,$missingTotal,$filledTotal);

        return $total;
    }

    public function detailPoolPallet() //Grafik Pallet Status (Good, TBR, BER, Missing) di Warehouse
    {
        $poolName = request()->detail_pool_name;
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
            $filledTotal = PoolPallet::select(DB::raw('sum(filled_pallet) as total'))
            ->where('pool_name', '=', "$poolName")
            ->get()
            ->toArray();     

            $total = array_merge($goodTotal,$tbrTotal,$berTotal,$missingTotal,$filledTotal);

        return $total;
    }

    public function detailTransporter() //Grafik Pallet Status (Good, TBR, BER, Missing) di Transporter
    {
        $transporterName = request()->detail_transporter_name;
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
            $filledTotal = Transporter::select(DB::raw('sum(filled_pallet) as total'))
            ->where('transporter_name', '=', "$transporterName")
            ->get()
            ->toArray();       

            $total = array_merge($goodTotal,$tbrTotal,$berTotal,$missingTotal,$filledTotal);

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

    // public function allTransactionDownload()
    // {
    //     $alltransactiontoday = DB::table('all_transaction as a')
    //     // ->orderBy('created_at', 'DESC')
    //     ->leftJoin('surat_jalan_pallet as b', 'a.reference_sjp_id', '=', 'b.sjp_id')
    //     ->leftJoin('sjp_status as c', 'a.reference_sjp_status_id', '=', 'c.sjp_status_id')
    //     ->leftJoin('pallet_transfer as d', 'a.reference_pallet_transfer_id', '=', 'd.pallet_transfer_id')
    //     ->leftJoin('ber_missing_pallet as e', 'a.reference_ber_missing_id', '=', 'e.ber_missing_pallet_id')
    //     ->leftJoin('new_pallet as f', 'a.reference_new_pallet_id', '=', 'f.new_pallet_id')
    //     ->leftJoin('damaged_pallet as g', 'a.reference_damaged_pallet_id', '=', 'g.damaged_pallet_id')
    //     ->leftJoin('repaired_pallet as h', 'a.reference_repaired_pallet_id', '=', 'h.repaired_pallet_id')
    //     ->select('a.*', 'b.sjp_number', 'c.sjps_number', 'd.tp_number',
    //             'e.bmp_number', 'f.np_number', 'g.dp_number', 'h.rp_number')
    //     ->whereDate('a.created_at', '=', Carbon::today()->toDateString())
    //     ->latest()
    //     ->get();
    
    // return $alltransactiontoday;
    // }

    public function exportData(Request $request)
    {
        $transaction = $this->chart();
        return Excel::download(new TransactionExport($transaction, request()->month, request()->year), 'transaction.xlsx');
    }
}
