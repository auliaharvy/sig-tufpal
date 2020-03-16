<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\BermissingpalletdisapprovedCollection;
use App\Bermissingdisapproved;
use DB;

class BermissingpalletdisapprovedController extends Controller
{
    public function index()
    {
        $bermissingpalletdisapproved = new BermissingpalletdisapprovedCollection(Bermissingdisapproved::paginate(10000000));
		 return $bermissingpalletdisapproved;
        // return response()->json(Sjp::all()->toArray());
    }

}
