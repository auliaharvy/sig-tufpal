<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpchangedestinationCollection;
use App\Sjpchangedestination;
use DB;

class SjpchangedestinationController extends Controller
{
    public function index()
    {
        $sjpchangedestination = new SjpchangedestinationCollection(Sjpchangedestination::paginate(10000000));
		 return $sjpchangedestination;
        // return response()->json(Sjp::all()->toArray());
    }

}
