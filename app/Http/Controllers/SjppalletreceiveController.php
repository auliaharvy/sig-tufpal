<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjppalletreceiveCollection;
use App\Sjppalletreceive;
use DB;

class SjppalletreceiveController extends Controller
{
    public function index()
    {
        $sjppalletreceive = new SjppalletreceiveCollection(Sjppalletreceive::paginate(10000000));
		 return $sjppalletreceive;
        // return response()->json(Sjp::all()->toArray());
    }

}
