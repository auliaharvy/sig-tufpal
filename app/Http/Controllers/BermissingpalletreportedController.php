<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\BermissingpalletreportedCollection;
use App\Bermissingreported;
use DB;

class BermissingpalletreportedController extends Controller
{
    public function index()
    {
        $bermissingpalletreported = new BermissingpalletreportedCollection(Bermissingreported::paginate(10000000));
		 return $bermissingpalletreported;
        // return response()->json(Sjp::all()->toArray());
    }

}
