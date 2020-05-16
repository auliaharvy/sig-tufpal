<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\SjpStatus;
use App\Sjp;
use App\PoolPallet;
use App\Transporter;
use App\Bermissing;
use DB;

class DispatchDataController extends Controller
{
    public function dispatchData(Request $request)
    {
        $vehicle = $request->vehicle_number;
        // $url = 'https://b2b.indocement.co.id/WSTufpalBridge_TEST/TUFPAL.svc/json/GetDataDispatch/B 9072XQ';

        // $ch = curl_init();
        // curl_setopt($ch, CURLOPT_URL, $url);
        // curl_setopt($ch, CURLOPT_POST,0);
        // curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

        // $response = curl_exec ($ch);
        // // $err = curl_error($ch);  //if you need
        // curl_close ($ch);
        // return $response;

        $client = new \GuzzleHttp\Client();
        $response = $client->request('GET', 'https://b2b.indocement.co.id/WSTufpalBridge/TUFPAL.svc/json/GetDataDispatch/'.$vehicle, [
            'headers' => [
                'API-key' => '99cf18ca-7ae1-4571-a076-815e94eb22c5',
            ]
        ]);

        // return $response->getStatusCode(); // 200
        // return $response->getHeaderLine('content-type'); // 'application/json; charset=utf8'
        return $response->getBody();

    }
}
