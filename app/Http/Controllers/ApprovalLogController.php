<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\ApprovalLog;
use DB;

class AlltransactionController extends Controller
{
    public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        if($pool_pallet==1 && $role<7){
            $approval_log = DB::table('approval_log as a')
            ->orderBy('created_at', 'DESC')
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $approval_log = DB::table('approval_log as a')
            ->orderBy('created_at', 'DESC')
            ->paginate(10000000)
            ->toArray();
        }
        return $approval_log;
    }
}