<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjppalletsendCollection;
use App\Sjppalletsend;
use DB;

class SjppalletsendController extends Controller
{
    public function index()
    {
        $sjppalletsend = new SjppalletsendCollection(Sjppalletsend::paginate(10000000));
		 return $sjppalletsend;
        // return response()->json(Sjp::all()->toArray());
    }

}
