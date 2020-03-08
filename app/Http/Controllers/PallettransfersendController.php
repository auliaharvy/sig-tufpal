<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\PallettransfersendCollection;
use App\Pallettransfersend;
use DB;

class PallettransfersendController extends Controller
{
    public function index()
    {
        $pallettransfersend = new PallettransfersendCollection(Pallettransfersend::paginate(10000000));
		 return $pallettransfersend;
        // return response()->json(Sjp::all()->toArray());
    }

}
