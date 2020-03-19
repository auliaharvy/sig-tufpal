<?php

namespace App\Http\Controllers\API;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Carbon\Carbon;
use App\Transaction;
use App\Sjppalletsend;
use DB;
use Excel;
use App\Exports\TransactionExport;

class DashboardController extends Controller
{
    public function chart()
    {
        $filter = request()->year . '-' . request()->month;
        $parse = Carbon::parse($filter);
        $array_date = range($parse->startOfMonth()->format('d'), $parse->endOfMonth()->format('d'));
        $sjppalletsend = Sjppalletsend::select(DB::raw('date(created_at) as date,sum(good_pallet) as total'))
            ->where('created_at', 'LIKE', '%' . $filter . '%')
            ->groupBy(DB::raw('date(created_at)'))->get();
        
        $data = [];
        foreach ($array_date as $row) {
            $f_date = strlen($row) == 1 ? 0 . $row:$row;
            $date = $filter . '-' . $f_date;
            $total = $sjppalletsend->firstWhere('date', $date);

            $data[] = [
                'date' =>$date,
                'total' => $total ? $total->total:0
            ];
        }
        return $data;
    }

    public function exportData(Request $request)
    {
        $transaction = $this->chart();
        return Excel::download(new TransactionExport($transaction, request()->month, request()->year), 'transaction.xlsx');
    }
}
