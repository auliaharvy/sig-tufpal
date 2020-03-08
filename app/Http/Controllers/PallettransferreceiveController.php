<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\PallettransferreceiveCollection;
use App\Pallettransferreceive;
use DB;

class PallettransferreceiveController extends Controller
{
    public function index()
    {
        $pallettransferreceive = new PallettransferreceiveCollection(Pallettransferreceive::paginate(10000000));
		 return $pallettransferreceive;
        // return response()->json(Sjp::all()->toArray());
    }

}
