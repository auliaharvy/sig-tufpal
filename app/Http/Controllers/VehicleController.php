<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use App\Vehicle;
use DB;

class VehicleController extends Controller
{
    public function index()
    {
        $vehicle = new SjpStatusCollection(Vehicle::paginate(10));
		 return $vehicle;
        // return response()->json(Sjp::all()->toArray());
    }

    

}
