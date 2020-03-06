<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpadjusmentCollection;
use App\Sjpadjusment;
use DB;

class SjpadjusmentController extends Controller
{
    public function index()
    {
        $adjusment = new SjpadjusmentCollection(Sjpadjusment::paginate(10000000));
		 return $adjusment;
        // return response()->json(Sjp::all()->toArray());
    }

}
