<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use App\Driver;
use DB;

class DriverController extends Controller
{
    public function index()
    {
        $driver = new SjpStatusCollection(Driver::paginate(10));
		 return $driver;
        // return response()->json(Sjp::all()->toArray());
    }

    

}
