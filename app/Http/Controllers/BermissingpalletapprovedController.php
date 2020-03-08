<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\BermissingpalletapprovedCollection;
use App\Bermissingapproved;
use DB;

class BermissingpalletapprovedController extends Controller
{
    public function index()
    {
        $bermissingpalletapproved = new BermissingpalletapprovedCollection(Bermissingapproved::paginate(10000000));
		 return $bermissingpalletapproved;
        // return response()->json(Sjp::all()->toArray());
    }

}
