<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use App\MstTransaction;
use App\SjpStatus;
use DB;

class MstTransactionController extends Controller
{
    public function index()
    {
        $msttransaction = new SjpStatusCollection(MstTransaction::paginate(10));
		 return $msttransaction;
        // return response()->json(Sjp::all()->toArray());
    }

    

}
