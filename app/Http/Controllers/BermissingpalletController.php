<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\BermissingpalletCollection;
use Illuminate\Support\Facades\Auth;
use App\Bermissing;
use App\SjpStatus;
use App\Transporter;
use App\PoolPallet;
use DB;

class BermissingpalletController extends Controller
{
    public function index()
    {
        // $sjp = new SjpCollection(Sjp::paginate(10));
		//  return $sjp;
        // return response()->json(Sjp::all()->toArray());
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        if($pool_pallet==null){
            $bermissing = DB::table('ber_missing_pallet as a')
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->join('users as c', 'a.approver_user_id', '=', 'c.id')
            ->join('pool_pallet as d', 'a.pool_pallet_id', '=', 'd.pool_pallet_id')
            ->join('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
            ->join('sjp_status as f', 'a.reference_sjp_status_id', '=', 'f.sjp_status_id')
            ->select('a.*', 'b.name as reporter', 'c.name as approver',
                    'd.pool_name','e.transporter_name', 'f.sjp_number')
           
            ->paginate(10)
            ->toArray();
        }
        else{
            $bermissing = DB::table('ber_missing_pallet as a')
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->join('users as c', 'a.approver_user_id', '=', 'c.id')
            ->join('pool_pallet as d', 'a.pool_pallet_id', '=', 'd.pool_pallet_id')
            ->join('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
            ->join('sjp_status as f', 'a.reference_sjp_status_id', '=', 'f.sjp_status_id')
            ->select('a.*', 'b.name as reporter', 'c.name as approver',
                    'd.pool_name','e.transporter_name', 'f.sjp_number')
            ->where('d.pool_pallet_id',$pool_pallet)
            ->paginate(10)
            ->toArray();
        }
        
        $bermissing = new BermissingpalletCollection(Bermissing::paginate(10));
        return $bermissing;
        // //return response()->json(Bermissing::all()->toArray());
    }

    public function show($ber_missing_pallet_id)
    {
        $bermissing = Bermissing::find($ber_missing_pallet_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $bermissing]);
    }

    public function store(Request $request)
    {
        $ber_missing_pallet_id = $request->ber_missingPallet_id;
        $transporter_id = $request->transporter_id;
        $pool_pallet_id = $request->pool_pallet_id;

        $bermissing = Bermissing::create([
            'reporter_user_id' => auth()->user()->id,
            'approver_user_id' => 5,
            'pool_pallet_id' => auth()->user()->reference_pool_pallet_id, 
            'transporter_id' => auth()->user()->reference_transporter_id, 
            'ber_pallet' => $request->ber_pallet, 
            'missing_pallet' => $request->missing_pallet, 
            'reporter_prove' => $request->reporter_prove,
            'status' => 0,
            'note' => $request->note, 
        ]);
        
        if($pool_pallet_id!=null){
            $InventoryPool = PoolPallet::find($pool_pallet_id);
            $InventoryPool->good_pallet = (($InventoryPool->good_pallet)-(($request->ber_pallet)+($request->missing_pallet)));
            $InventoryPool->ber_pallet = (($InventoryPool->ber_pallet)+($request->ber_pallet));
            $InventoryPool->missing_pallet = (($InventoryPool->missing_pallet)+($request->missing_pallet));
            $InventoryPool->save();
        }
        
        if($transporter_id!=null){
            $InventoryTrans = Transporter::find($transporter_id);
            $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-(($request->ber_pallet)+($request->missing_pallet)));
            $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)+($request->ber_pallet));
            $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)+($request->missing_pallet));
            $InventoryTrans->save();
        }
       

        $data = [
            'data' => $bermissing,
            'status' => (bool) $bermissing,
            'message' => $bermissing ? 'BER/Missing Pallet Record Created!' : 'Error BER/Missing Pallet Record' 
        ];

        return response()->json($data);
    }

    public function edit($id)
    {
        $bermissing = Bermissing::find($id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $bermissing]);
    }

    public function approve(Request $request)
    {
        $ber_missing_pallet_id = $request->ber_missing_pallet_id;
        $transporter_id = $request->transporter_id;
        $pool_pallet_id = $request->pool_pallet_id;

        $bermissing = Bermissing::where('ber_missing_pallet_id',$ber_missing_pallet_id)->first();
        if (empty($bermissing)){
            return response()->json(['error' => 'Data not found'], 404);
        }
        else{
            $update = Bermissing::find($ber_missing_pallet_id);
            $update->reporter_user_id = $request->reporter_user_id;
            $update->approver_user_id = auth()->user()->id;
            $update->pool_pallet_id = $request->pool_pallet_id;
            $update->transporter_id = $request->transporter_id;
            $update->ber_pallet = $request->ber_pallet;
            $update->missing_pallet = $request->missing_pallet; 
            $update->reporter_prove = $request->reporter_prove;
            $update->status = 1;
            $update->note = $request->note; 
            $update->save();

            if($pool_pallet_id!=null){
                $InventoryPool = PoolPallet::find($pool_pallet_id);
                $InventoryPool->ber_pallet = (($InventoryPool->ber_pallet)-($request->ber_pallet));
                $InventoryPool->missing_pallet = (($InventoryPool->missing_pallet)-($request->missing_pallet));
                $InventoryPool->save();
            }
            
            if($transporter_id!=null){
                $InventoryTrans = Transporter::find($transporter_id);
                $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)-($request->ber_pallet));
                $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)-($request->missing_pallet));
                $InventoryTrans->save();
            }

        }

       

        $data = [
            'data' => $update,
            'status' => (bool) $update,
            'message' => $update ? 'Pallet Transfer Record Updated!' : 'Error Updating Pallet Transfer Record' 
        ];

        return response()->json($data);
    }

    public function destroy($id)
    {
        $bermissing = Bermissing::find($id); //QUERY DATA BERDASARKAN ID
        $bermissing->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
