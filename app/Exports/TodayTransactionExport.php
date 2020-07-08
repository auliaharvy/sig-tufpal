<?php

namespace App\Exports;

use App\Alltransaction;
use Illuminate\Contracts\View\View;
use Maatwebsite\Excel\Concerns\FromView;
use Maatwebsite\Excel\Concerns\ShouldAutoSize;

class TodayTransactionExport implements FromView, ShouldAutoSize
{
    protected $alltransactiontoday;
    public function __construct($alltransactiontoday)
    {
        $this->alltransactiontoday = $alltransactiontoday;
    }

    public function view(): View
    {
        return view('exports.todaytransaction', [
            'alltransactiontoday' => $this->alltransactiontoday,
        ]);
    }
}
