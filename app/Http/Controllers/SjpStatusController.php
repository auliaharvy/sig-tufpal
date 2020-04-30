<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\SjpStatusCollection;
use Illuminate\Support\Facades\Auth;
use App\SjpStatus;
use App\Sjp;
use App\PoolPallet;
use App\Transporter;
use App\Bermissing;
use App\Bermissingreported;
use App\Vehicle;
use App\Driver;
use App\Damagedpallet;
use App\Sjppalletsend;
use App\Sjppalletreceive;
use App\Alltransaction;
use DB;

class SjpStatusController extends Controller
{
    
public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        $status = 'OPEN';
        if($pool_pallet==1 && $role<6){
        $sjpstatus = DB::table('sjp_status as a')
            ->join('users as b', 'a.checker_send_user_id', '=', 'b.id')
            ->join('users as c', 'a.checker_receive_user_id', '=', 'c.id')
            ->join('surat_jalan_pallet as d', 'a.sjp_id', '=', 'd.sjp_id')
            ->join('mst_transaction as e', 'a.transaction_id', '=', 'e.id')
            ->join('vehicle as f', 'd.vehicle_id', '=', 'f.vehicle_id')
            ->join('transporter as g', 'd.transporter_id', '=', 'g.transporter_id')
            ->join('pool_pallet as h', 'd.departure_pool_pallet_id', '=', 'h.pool_pallet_id')
            ->join('pool_pallet as i', 'd.destination_pool_pallet_id', '=', 'i.pool_pallet_id')
            ->select('a.*', 'b.name as checker_sender', 'c.name as checker_receiver',
                    'd.sjp_number','e.transaction', 'd.is_sendback', 'd.destination_pool_pallet_id'
                    , 'd.departure_pool_pallet_id', 'd.transporter_id', 'f.vehicle_number'
                    , 'g.transporter_name', 'h.pool_name as dept_pool ', 'i.pool_name as dest_pool'
                    , 'd.distribution' )
            ->where('d.status',$status)            
            ->paginate(1000000)
            ->toArray();
        }
        else{
            $sjpstatus = DB::table('sjp_status as a')
            ->join('users as b', 'a.checker_send_user_id', '=', 'b.id')
            ->join('users as c', 'a.checker_receive_user_id', '=', 'c.id')
            ->leftJoin(DB::raw('(SELECT * FROM surat_jalan_pallet WHERE STATUS = "OPEN")d'),
            function($join){
                $join->on('a.sjp_id','=','d.sjp_id');
            })
            ->join('mst_transaction as e', 'a.transaction_id', '=', 'e.id')
            ->join('vehicle as f', 'd.vehicle_id', '=', 'f.vehicle_id')
            ->join('transporter as g', 'd.transporter_id', '=', 'g.transporter_id')
            ->join('pool_pallet as h', 'd.departure_pool_pallet_id', '=', 'h.pool_pallet_id')
            ->join('pool_pallet as i', 'd.destination_pool_pallet_id', '=', 'i.pool_pallet_id')
            ->select('a.*', 'b.name as checker_sender', 'c.name as checker_receiver',
                    'd.sjp_number','e.transaction', 'd.is_sendback', 'd.destination_pool_pallet_id'
                    , 'd.departure_pool_pallet_id', 'd.transporter_id', 'f.vehicle_number'
                    , 'g.transporter_name', 'h.pool_name as dept_pool ', 'i.pool_name as dest_pool'
                    , 'd.distribution' )       
            ->where('d.departure_pool_pallet_id',$pool_pallet)
            ->orWhere('d.destination_pool_pallet_id', $pool_pallet)
            ->orWhere('d.transporter_id', $transporter)
            ->paginate(10000000)
            ->toArray();
        }
        return $sjpstatus;
    }

    public function show($sjp_status_id)
    {
        $sjpstatus = SjpStatus::find($sjp_status_id); 
        return response()->json(['status' => 'success', 'data' => $sjpstatus]);
    }

    public function sjpstatusbymaster($sjp_id)
    {
        $sjp = Sjp::find($sjp_id);
        return response()->json(['status' => 'success', 'data' => $sjp]);   
    }

    public function view($sjp_status_id)
    {
        
        $sjpstatus = SjpStatus::find($sjp_status_id);
        $sjp_id = $sjpstatus->sjp_id;
        $sjp = Sjp::find($sjp_id);
        $sjp_number = $sjp->sjp_number;

        $data[] = [
            'sjp_number' =>$sjp_number,
        ];
        return response()->json(['status' => 'success', 'data' => $data]);   
    }

    
    public function store(Request $request)
    {
        $sjp_id = $request->sjp_id;
        $sjp_status_id = $request->sjp_status_id;
        $sjp = DB::table('surat_jalan_pallet')->where('sjp_id',$sjp_id)->first();
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $pallet = PoolPallet::find($pool_pallet);
        $sjp_number = $sjp->sjp_number;
        $qty_pool = $pallet->good_pallet;
        $departure_id = $sjp->departure_pool_pallet_id;
        $transporter_id = $sjp->transporter_id;
        $driver_id = $sjp->driver_id;
        $vehicle_id = $sjp->vehicle_id;
        $sendback = $sjp->is_sendback;
        $pallet_qty = $sjp->pallet_quantity;
        $cement_qty = $sjp->product_quantity;
        $good_pallet = $request->good_pallet;
        $tbr_pallet = $request->tbr_pallet;
        $ber_pallet = $request->ber_pallet;
        $missing_pallet = $request->missing_pallet;
        $total = $good_pallet+$tbr_pallet+$ber_pallet+$missing_pallet;

        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1|in:'.$pallet_qty,
            'driver_approval' => 'required',
            // 'tbr_pallet' => 'required|integer|gt:-1',
            // 'ber_pallet' => 'required|integer|gt:-1',
            // 'missing_pallet' => 'required|integer|gt:-1',
            // 'good_cement' => 'required|integer|gt:-1|in:'.$cement_qty,
            // 'bad_cement' => 'required|integer|gt:-1'
        ]);
        // if($pallet_qty<$total)
        // {
        //     return response()->json(['error' => 'Pallet Melebihi Qty yang ada'], 422);
        // }
        //else{
            // if(($request->transaction_id)==1){ //send pool to wh
            //     $sendback = 0;
            //     $departure_id = $sjp->departure_pool_pallet_id;
            //     $destination_id = $sjp->destination_pool_pallet_id;
            // }
            // else{ //statuss = 2 or send wh to pool
            //     $destination_id = $sjp->departure_pool_pallet_id;
            //     $departure_id = $sjp->destination_pool_pallet_id;
            // }
            // $destination_id = $sjp->destination_pool_pallet_id;
            $checker = Auth::user()->id;
            DB::beginTransaction();
            try{
                $name = NULL;
                if ($request->hasFile('driver_approval')) {
                    $file = $request->file('driver_approval');
                    $name = 'driver_approval'. '-' . $sjp_number . '-' . time() . '.' . $file->getClientOriginalExtension();
                    $file->storeAs('public/driver_approval', $name);
                }
                $sjpStatus = SjpStatus::create([
                    'checker_send_user_id' => $checker, 
                    'checker_receive_user_id' => 5, 
                    'sjp_id' => $request->sjp_id,
                    'good_pallet' => $request->good_pallet, 
                    'tbr_pallet' => 0, 
                    'ber_pallet' => 0, 
                    'missing_pallet' => 0, 
                    'good_cement' => $sjp->product_quantity, 
                    'bad_cement' => 0, 
                    'driver_approval' => $name,
                    'transaction_id' => 1,
                    'note' => $request->note, 
                    'status' => 0,
                ]);
                // $sjpstatusid = $sjpStatus->id;

                $sjpSendback = Sjp::find($sjp_id);
                $sjpSendback->is_sendback = 0;
                $sjpSendback->save();

                $state = Sjp::find($sjp_id);
                $state->state=1;
                $state->save();
                
                $departure_id = $sjp->departure_pool_pallet_id;
                $destination_id = $sjp->destination_pool_pallet_id;

                // Membuat log all transaksi send
                $sender = Auth::user()->name;
                $sjp_id = $sjp->sjp_id;
                $sjps_number = 'SEND';
                $palletsenddept = PoolPallet::find($departure_id);
                $palletsenddest = PoolPallet::find($destination_id);
                $palletsendtrans = Transporter::find($transporter_id);
                $palletsenddriver = Driver::find($driver_id);
                $palletsendvehicle = Vehicle::find($vehicle_id);
                $alltransaction = Alltransaction::create([
                    'reference_sjp_id' => $sjp_id,
                    'reference_sjp_status_id' => $sjpStatus->sjp_status_id,
                    'transaction' => 'SJP Status Send',
                    'status' => 'SEND',
                    'no_do' => $sjp->no_do,
                    'sender/reporter' => $sender,
                    'departure_pool' => $palletsenddept->pool_name, 
                    'destination_pool' => $palletsenddest->pool_name,
                    'transporter' => $palletsendtrans->transporter_name,
                    'driver' => $palletsenddriver->driver_name,
                    'vehicle' => $palletsendvehicle->vehicle_number,
                    'good_pallet' => $request->good_pallet, 
                    'note' => $request->note,
                    'tbr_pallet' => 0, 
                    'ber_pallet' => 0, 
                    'missing_pallet' => 0, 
                    'good_cement' => $sjp->product_quantity,
                    'bad_cement' => 0,
                    'driver_approval' => $name,
                    'note' => $request->note
                ]);

                // Membuat log transaksi send
                $sender = Auth::user()->name;
                $sjp_number = $sjp->sjp_number;
                $sjps_number = 'SEND';
                $palletsenddept = PoolPallet::find($departure_id);
                $palletsenddest = PoolPallet::find($destination_id);
                $palletsendtrans = Transporter::find($transporter_id);
                $palletsenddriver = Driver::find($driver_id);
                $palletsendvehicle = Vehicle::find($vehicle_id);
                $Sjpsend = Sjppalletsend::create([
                    'sjp_status_id' => $sjpStatus->sjp_status_id,
                    'sjp_number' => $sjp_number,
                    'sjp_status' => $sjps_number,
                    'sender' => $sender,
                    'departure_pool' => $palletsenddept->pool_name, 
                    'destination_pool' => $palletsenddest->pool_name,
                    'transporter' => $palletsendtrans->transporter_name,
                    'driver' => $palletsenddriver->driver_name,
                    'vehicle' => $palletsendvehicle->vehicle_number,
                    'good_pallet' => $request->good_pallet, 
                    'note' => $request->note,
                    'tbr_pallet' => 0, 
                    'ber_pallet' => 0, 
                    'missing_pallet' => 0, 
                    'good_cement' => $sjp->product_quantity,
                    'bad_cement' => 0,
                    'driver_approval' => $name,
                    'note' => $request->note
                ]);
                
                $departure_id = $sjp->departure_pool_pallet_id;
                $InventoryDept = PoolPallet::find($departure_id);
                $InventoryDept->good_pallet = (($InventoryDept->good_pallet)-($request->good_pallet));
                $InventoryDept->tbr_pallet = (($InventoryDept->tbr_pallet)-($request->tbr_pallet));
                $InventoryDept->ber_pallet = (($InventoryDept->ber_pallet)-($request->ber_pallet));
                $InventoryDept->missing_pallet = (($InventoryDept->missing_pallet)-($request->missing_pallet));
                $InventoryDept->save();

                $transporter_id = $sjp->transporter_id;
                $InventoryTrans = Transporter::find($transporter_id);
                $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)+($request->good_pallet));
                $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)+($request->tbr_pallet));
                $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)+($request->ber_pallet)); //anggeplah 0
                $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)+($request->missing_pallet)); //anggeplah 0
                $InventoryTrans->save();
                
                DB::commit();
                return response()->json(['status' => 'success'], 200);

            } catch (\Exception $e) {
                DB::rollback();
                return response()->json([
                    'status' => 'error', 
                    'data' => $e->getMessage(),
                    'message' => 'Error Surat Jalan Pallet Status Record'], 422);
            }   
        //}           
    }

    public function sendback(Request $request)
    {
        $sjp_id = $request->sjp_id;
        $sjp_status_id = $request->sjp_status_id;
        $sjp = DB::table('surat_jalan_pallet')->where('sjp_id',$sjp_id)->first();
        $distribution = $sjp->distribution;
        $departure_id = $sjp->destination_pool_pallet_id;
        $destination_id = $sjp->departure_pool_pallet_id;
        $transporter_id = $sjp->transporter_id;
        $driver_id = $sjp->driver_id;
        $vehicle_id = $sjp->vehicle_id;
        $sendback = $sjp->is_sendback;
        $departure = PoolPallet::find($departure_id);
        $good_pallet = $departure->good_pallet;
        $tbr_pallet = $departure->tbr_pallet;
        $ber_pallet = $departure->ber_pallet;
        $missing_pallet = $departure->missing_pallet;
        $total = $good_pallet+$tbr_pallet+$ber_pallet+$missing_pallet;
        
        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1|lte:'.$good_pallet,
            'tbr_pallet' => 'required|integer|gt:-1|lte:'.$tbr_pallet,
            'ber_pallet' => 'required|integer|gt:-1|lte:'.$ber_pallet,
            'missing_pallet' => 'required|integer|gt:-1|lte:'.$ber_pallet,
            // 'good_cement' => 'required|integer|gt:-1',
            // 'bad_cement' => 'required|integer|gt:-1'
        ]);
        // if($pallet_qty<$total)
        // {
        //     return response()->json(['error' => 'Pallet Melebihi Qty yang ada'], 422);
        // }
        //else{
            // if(($request->transaction_id)==1){ //send pool to wh
            //     $sendback = 0;
            //     $departure_id = $sjp->departure_pool_pallet_id;
            //     $destination_id = $sjp->destination_pool_pallet_id;
            // }
            // else{ //statuss = 2 or send wh to pool
            //     $destination_id = $sjp->departure_pool_pallet_id;
            //     $departure_id = $sjp->destination_pool_pallet_id;
            // }
            
            if ($distribution == 1){
                $departure_id = $sjp->destination_pool_pallet_id;
                $destination_id = $sjp->departure_pool_pallet_id;
            }

            $checker = Auth::user()->id;
            DB::beginTransaction();
            try{
            $sjpStatus = SjpStatus::create([
                'checker_send_user_id' => $checker, 
                'checker_receive_user_id' => 5, 
                'sjp_id' => $request->sjp_id,
                'good_pallet' => $request->good_pallet, 
                'tbr_pallet' => $request->tbr_pallet, 
                'ber_pallet' => $request->ber_pallet,
                'missing_pallet' => $request->missing_pallet, 
                // 'good_cement' => $request->good_cement, 
                // 'bad_cement' => 0, 
                'transaction_id' => 2,
                'note' => $request->note, 
                'status' => 0,
            ]);
            // $sjpstatusid = $sjpStatus->id;

            $sjpSendback = Sjp::find($sjp_id);
            $sjpSendback->is_sendback = 1;
            $sjpSendback->save();

            $state = Sjp::find($sjp_id);
            $state->state=3;
            $state->save();

            // Membuat log all transaksi send
            $sender = Auth::user()->name;
            $sjp_id = $sjp->sjp_id;
            $sjps_number = 'RECEIVE';
            $palletsenddept = PoolPallet::find($departure_id);
            $palletsenddest = PoolPallet::find($destination_id);
            $palletsendtrans = Transporter::find($transporter_id);
            $palletsenddriver = Driver::find($driver_id);
            $palletsendvehicle = Vehicle::find($vehicle_id);
            $alltransaction = Alltransaction::create([
                'reference_sjp_id' => $sjp_id,
                'reference_sjp_status_id' => $sjpStatus->sjp_status_id,
                'transaction' => 'SJP Status Sendback',
                'status' => 'SENDBACK',
                'no_do' => $sjp->no_do,
                'sender/reporter' => $sender,
                'departure_pool' => $palletsenddept->pool_name, 
                'destination_pool' => $palletsenddest->pool_name,
                'transporter' => $palletsendtrans->transporter_name,
                'driver' => $palletsenddriver->driver_name,
                'vehicle' => $palletsendvehicle->vehicle_number,
                'good_pallet' => $request->good_pallet, 
                'note' => $request->note,
                'tbr_pallet' => $request->tbr_pallet, 
                'ber_pallet' => 0, 
                'missing_pallet' => 0, 
                'good_cement' => 0,
                'bad_cement' => 0,
                'note' => $request->note
            ]);
            
            // Membuat log transaksi send
            $sender = Auth::user()->name;
            $sjp_number = $sjp->sjp_number;
            $sjps_number = 'SEND BACK';
            $palletsenddept = PoolPallet::find($departure_id);
            $palletsenddest = PoolPallet::find($destination_id);
            $palletsendtrans = Transporter::find($transporter_id);
            $palletsenddriver = Driver::find($driver_id);
            $palletsendvehicle = Vehicle::find($vehicle_id);
            $Sjpsend = Sjppalletsend::create([
                'sjp_status_id' => $sjpStatus->sjp_status_id,
                'sjp_number' => $sjp_number,
                'sjp_status' => $sjps_number,
                'sender' => $sender,
                'departure_pool' => $palletsenddept->pool_name, 
                'destination_pool' => $palletsenddest->pool_name,
                'transporter' => $palletsendtrans->transporter_name,
                'driver' => $palletsenddriver->driver_name,
                'vehicle' => $palletsendvehicle->vehicle_number,
                'good_pallet' => $request->good_pallet, 
                'tbr_pallet' => $request->tbr_pallet, 
                'ber_pallet' => $request->ber_pallet, 
                'missing_pallet' => $request->missing_pallet, 
                // 'good_cement' => $request->good_cement,
                // // 'bad_cement' => $request->bad_cement,
                'note' => $request->note,
            ]);
            
            $InventoryDept = PoolPallet::find($departure_id);
            $InventoryDept->good_pallet = (($InventoryDept->good_pallet)-($request->good_pallet));
            $InventoryDept->tbr_pallet = (($InventoryDept->tbr_pallet)-($request->tbr_pallet));
            $InventoryDept->ber_pallet = (($InventoryDept->ber_pallet)-($request->ber_pallet));
            $InventoryDept->missing_pallet = (($InventoryDept->missing_pallet)-($request->missing_pallet));
            $InventoryDept->save();

            $InventoryTrans = Transporter::find($transporter_id);
            $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)+($request->good_pallet));
            $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)+($request->tbr_pallet));
            $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)+($request->ber_pallet)); //anggeplah 0
            $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)+($request->missing_pallet)); //anggeplah 0
            $InventoryTrans->save();

            DB::commit();
            return response()->json(['status' => 'success'], 200);
            // $data = [
            //     'data' => $sjpStatus,
            //     'status' => (bool) $sjpStatus,
            //     'message' => $sjpStatus ? 'SJP Status Record Created!' : 'Error Creating SJP Status Record' 
            // ];

            // return response()->json($data);
            } catch (\Exception $e) {
                DB::rollback();
                return response()->json([
                    'status' => 'error', 
                    'data' => $e->getMessage(),
                    'message' => 'Error SJP Status Sendback Record'], 422);
            }      
        //}           
    }

    public function receive(Request $request)
    {
        $sjp_id = $request->sjp_id;
        $sjp_status_id = $request->sjp_status_id;
        $sjp = DB::table('surat_jalan_pallet')->where('sjp_id',$sjp_id)->first();
        $departure_id = $sjp->departure_pool_pallet_id;
        $destination_id = $sjp->destination_pool_pallet_id;
        $transporter_id = $sjp->transporter_id;
        $driver_id = $sjp->driver_id;
        $vehicle_id = $sjp->vehicle_id;
        $pallet_qty = $sjp->pallet_quantity;
        $good_cement = $sjp->product_quantity;
        $update = SjpStatus::find($sjp_status_id);
        $good_pallet = $update->good_pallet;
       
        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1|lte:'.$pallet_qty,
            // 'tbr_pallet' => 'required|integer|gt:-1',
            // 'ber_pallet' => 'required|integer|gt:-1',
            // 'missing_pallet' => 'required|integer|gt:-1',
            'good_cement' => 'required|integer|gt:-1|lte:'.$good_cement,
            // 'bad_cement' => 'required|integer|gt:-1'
        ]);
        // if(($request->transaction_id)==1){ //send 
        //     $departure_id = $sjp->departure_pool_pallet_id;
        //     $destination_id = $sjp->destination_pool_pallet_id;
        //     $status = $sjp->status;
        // }
        // else{ //statuss = 2 or send back
            
        //     $status = 'CLOSED';
        //     $destination_id = $sjp->departure_pool_pallet_id;
        //     $departure_id = $sjp->destination_pool_pallet_id;

        // }
        $sjpStatus = SjpStatus::where('sjp_status_id',$sjp_status_id)->first();
        if (empty($sjpStatus)){
            return response()->json(['error' => 'Data not found'], 404);
        }
        else{
            // $InventoryTrans = Transporter::find($transporter_id); //cek qty pallet di transporter
            // $good_pallet = $InventoryTrans->good_pallet;
            // $tbr_pallet  = $InventoryTrans->tbr_pallet;
            // $ber_pallet = $InventoryTrans->ber_pallet;
            // $missing_pallet = $InventoryTrans->missing_pallet;
            // $total = $good_pallet+$tbr_pallet+$ber_pallet+$missing_pallet;

            // if($good_pallet<$request->good_pallet || $total < $tbr_pallet || $total<$ber_pallet || $total<$missing_pallet ){
            //     return response()->json(['error' => 'Qty Receive melebihi data yang di send'], 404);
            // }
            // else{
                $goodpalletrcv = $request->good_pallet;
                $tbr_palletrcv = $request->tbr_pallet;
            if($tbr_palletrcv>($good_pallet-$goodpalletrcv)){
                return response()->json(['error' => 'Input Error! Total Quantity Of Received Pallet  Over Than Total Quantity Of Pallet Send'], 404);
            }else {
                $update = SjpStatus::find($sjp_status_id);
                DB::beginTransaction();
                try{
                $good_pallet_awal = $update->good_pallet; //ambil qty pallet awal
                $good_cement_awal = $update->good_cement; //ambil qty cement awal
                // $ber_pallet_awal = $update->ber_pallet; //ambil qty pallet awal
                // $missing_pallet_awal = $update->missing_pallet; //ambil qty pallet awal
                // $sjps_number    = $update->sjps_number;
                // $update->checker_send_user_id = $request->checker_send_user_id;
                $receive = Auth::user()->id;
                $update->checker_receive_user_id = $receive;
                // $update->sjp_id = $request->sjp_id;
                $update->good_pallet = $request->good_pallet;
                $update->tbr_pallet = $request->tbr_pallet;
                // $update->ber_pallet = $request->ber_pallet;
                // $update->missing_pallet = $request->missing_pallet;
                $update->good_cement = $request->good_cement;
                // $update->bad_cement = $request->bad_cement;
                $update->transaction_id = 1;
                $update->note = $request->note;
                $update->status = 1;
                $update->save();

                $InventoryDest = PoolPallet::find($destination_id);
                $InventoryDest->good_pallet = (($InventoryDest->good_pallet)+($request->good_pallet)); //hanya receive good pallet
                $InventoryDest->tbr_pallet = (($InventoryDest->tbr_pallet)+($request->tbr_pallet)); // ber & missing dicatat di transporter
                // $InventoryDest->ber_pallet = (($InventoryDest->ber_pallet)+($request->ber_pallet));
                // $InventoryDest->missing_pallet = (($InventoryDest->missing_pallet)+($request->missing_pallet));
                $InventoryDest->save();

                $InventoryTrans = Transporter::find($transporter_id);
                $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($request->good_pallet+$request->tbr_pallet));
                // $InventoryTrans->tbr_pallet = (($InventoryTrans->good_pallet)-($request->tbr_pallet)); //??
                // $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)+($request->ber_pallet)); //setiap ada ber / missing masuk ke transporter
                // $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)+($request->missing_pallet));
                $InventoryTrans->save();

                // Membuat log all transaksi send
                $receiver = Auth::user()->name;
                $sjp_id = $sjp->sjp_id;
                $sjps_number = 'RECEIVE';
                $palletsenddept = PoolPallet::find($departure_id);
                $palletsenddest = PoolPallet::find($destination_id);
                $palletsendtrans = Transporter::find($transporter_id);
                $palletsenddriver = Driver::find($driver_id);
                $palletsendvehicle = Vehicle::find($vehicle_id);
                $alltransaction = Alltransaction::create([
                    'reference_sjp_id' => $sjp_id,
                    'reference_sjp_status_id' => $sjpStatus->sjp_status_id,
                    'transaction' => 'SJP Status Receive',
                    'status' => 'RECEIVE',
                    'no_do' => $sjp->no_do,
                    'receiver/approver' => $receiver,
                    'departure_pool' => $palletsenddept->pool_name, 
                    'destination_pool' => $palletsenddest->pool_name,
                    'transporter' => $palletsendtrans->transporter_name,
                    'driver' => $palletsenddriver->driver_name,
                    'vehicle' => $palletsendvehicle->vehicle_number,
                    'good_pallet' => $request->good_pallet, 
                    'note' => $request->note,
                    'tbr_pallet' => $request->tbr_pallet, 
                    'ber_pallet' => 0, 
                    'missing_pallet' => 0, 
                    'good_cement' => $request->good_cement,
                    'bad_cement' => $request->bad_cement,
                    'note' => $request->note
                ]);


                // Membuat log transaksi Receive
                $receiver = Auth::user()->name;
                $sjp_number = $sjp->sjp_number;
                $sjps_number = 'RECEIVE';
                $palletsenddept = PoolPallet::find($departure_id);
                $palletsenddest = PoolPallet::find($destination_id);
                $palletsendtrans = Transporter::find($transporter_id);
                $palletsenddriver = Driver::find($driver_id);
                $palletsendvehicle = Vehicle::find($vehicle_id);
                $Sjpreceive = Sjppalletreceive::create([
                    'sjp_status_id' => $sjpStatus->sjp_status_id,
                    'sjp_number' => $sjp_number,
                    'sjp_status' => $sjps_number,
                    'receiver' => $receiver,
                    'departure_pool' => $palletsenddept->pool_name, 
                    'destination_pool' => $palletsenddest->pool_name,
                    'transporter' => $palletsendtrans->transporter_name,
                    'driver' => $palletsenddriver->driver_name,
                    'vehicle' => $palletsendvehicle->vehicle_number,
                    'good_pallet' => $request->good_pallet, 
                    // 'tbr_pallet' => $request->tbr_pallet, 
                    // 'ber_pallet' => $request->ber_pallet, 
                    // 'missing_pallet' => $request->missing_pallet, 
                    'good_cement' => $request->good_cement,
                    // 'bad_cement' => $request->bad_cement,
                    'note' => $request->note,
                ]);
                // if(($request->ber_pallet)>0 || ($request->missing_pallet>0)){
                //     $Bermissing = Bermissing::create([
                //         'reporter_user_id' => $request->checker_receive_user_id, 
                //         'approver_user_id' => 5, 
                //         'transporter_id' => $transporter_id,
                //         'reference_sjp_status_id' => $sjp_status_id,
                //         'ber_pallet' => $request->ber_pallet, 
                //         'missing_pallet' => $request->missing_pallet,
                //         'status' => 0,
                //         'note' => 'PALLET RUSAK/HILANG DITEMUKAN SAAT RECEIVE OLEH CHECKER',  
                //     ]);
                // }
                // if(($request->tbr_pallet)>0){
                //     $Damage = Damagedpallet::create([
                //         'reporter_user_id' => $request->checker_receive_user_id, 
                //         'transporter_id' => $transporter_id,
                //         'reference_sjp_status_id' => $sjp_status_id,
                //         'tbr_pallet' => $request->tbr_pallet, 
                //         'note' => 'PALLET RUSAK/TBR DITEMUKAN SAAT RECEIVE OLEH CHECKER',  
                //     ]);
                // }
                
                $state = Sjp::find($sjp_id);
                $state->state=2;
                $state->save();
                // $status = 'CLOSED';
                // $Sjpstat = Sjp::find($sjp_id);
                // $Sjpstat->status = $status;
                // $Sjpstat->save();

                DB::commit();
                return response()->json(['status' => 'success'], 200);
                // $data = [
                //     'data' => $sjpStatus,
                //     'status' => (bool) $sjpStatus,
                //     'message' => $sjpStatus ? 'SJP Status Record Created!' : 'Error Creating SJP Status Record' 
                // ];

                // return response()->json($data);
                } catch (\Exception $e) {
                    DB::rollback();
                    return response()->json([
                        'status' => 'error', 
                        'data' => $e->getMessage(),
                        'message' => 'Error SJP Status Receive Record'], 422);
                }      
            }
            // }
            
        }    
    }

    public function receivesendback(Request $request)
    {
        $sjp_id = $request->sjp_id;
        $sjp_status_id = $request->sjp_status_id;
        $sjp = DB::table('surat_jalan_pallet')->where('sjp_id',$sjp_id)->first();
        $departure_id = $sjp->destination_pool_pallet_id;
        $destination_id = $sjp->departure_pool_pallet_id;
        $transporter_id = $sjp->transporter_id;
        $driver_id = $sjp->driver_id;
        $vehicle_id = $sjp->vehicle_id;
        $status = 'CLOSED';
        $update = SjpStatus::find($sjp_status_id);
        $good_pallet = $update->good_pallet;
        $tbr_pallet = $update->tbr_pallet;
        $ber_pallet = $update->ber_pallet;
        $missing_pallet = $update->missing_pallet;
        $total = $good_pallet+$tbr_pallet+$ber_pallet+$missing_pallet;
        // $InventoryTrans = Transporter::find($transporter_id); //cek qty pallet di transporter
        // $good_pallet = $InventoryTrans->good_pallet;
        // $tbr_pallet = $InventoryTrans->tbr_pallet;
        // $ber_pallet = $InventoryTrans->ber_pallet;
        // $missing_pallet = $InventoryTrans->missing_pallet;
        // $total = $good_pallet+$tbr_pallet+$ber_pallet+$missing_pallet;
       
        $this->validate($request, [
            'good_pallet' => 'required|integer|gt:-1|lte:'.$total,
            'tbr_pallet' => 'required|integer|gt:-1|lte:'.$total,
            'ber_pallet' => 'required|integer|gt:-1|lte:'.$total,
            'missing_pallet' => 'required|integer|gt:-1|lte:'.$total,
            // 'good_cement' => 'required|integer|gt:-1|',
            // 'bad_cement' => 'required|integer|gt:-1'
        ]);
        // if(($request->transaction_id)==1){ //send 
        //     $departure_id = $sjp->departure_pool_pallet_id;
        //     $destination_id = $sjp->destination_pool_pallet_id;
        //     $status = $sjp->status;
        // }
        // else{ //statuss = 2 or send back
            
        //     $status = 'CLOSED';
        //     $destination_id = $sjp->departure_pool_pallet_id;
        //     $departure_id = $sjp->destination_pool_pallet_id;

        // }
        $sjpStatus = SjpStatus::where('sjp_status_id',$sjp_status_id)->first();
        if (empty($sjpStatus)){
            return response()->json(['error' => 'Data not found'], 404);
        }
        else{
            // $InventoryTrans = Transporter::find($transporter_id); //cek qty pallet di transporter
            // $good_pallet = $InventoryTrans->good_pallet;
            // $tbr_pallet  = $InventoryTrans->tbr_pallet;
            // $ber_pallet = $InventoryTrans->ber_pallet;
            // $missing_pallet = $InventoryTrans->missing_pallet;
            // $total = $good_pallet+$tbr_pallet+$ber_pallet+$missing_pallet;

            // if($good_pallet<$request->good_pallet || $total < $tbr_pallet || $total<$ber_pallet || $total<$missing_pallet ){
            //     return response()->json(['error' => 'Qty Receive melebihi data yang di send'], 404);
            // }
            // else{
                $update = SjpStatus::find($sjp_status_id);
                DB::beginTransaction();
                try{
                $good_pallet_awal = $update->good_pallet; //ambil qty pallet awal
                // $good_cement_awal = $update->good_cement; //ambil qty cement awal
                $tbr_pallet_awal = $update->tbr_pallet;
                $ber_pallet_awal = $update->ber_pallet; //ambil qty pallet awal
                $missing_pallet_awal = $update->missing_pallet; //ambil qty pallet awal
                $sjps_number    = $update->sjps_number;
                // $update->checker_send_user_id = $request->checker_send_user_id;
                $goodpalletrcv = $request->good_pallet;
                $tbr_palletrcv = $request->tbr_pallet;
                $good_tbr = $goodpalletrcv+$tbr_palletrcv;
                $ber_palletrcv = $request->ber_pallet;
                $missing_palletrcv = $request->missing_pallet;
                $missing_ber = $ber_palletrcv+$missing_palletrcv;
                if($tbr_palletrcv>($total-$goodpalletrcv) ||$missing_ber>($total-$good_tbr) ){
                    return response()->json(['error' => 'Qty Receive melebihi data yang di send'], 404);
                }
                else{
                    $receive = Auth::user()->id;
                    $update->checker_receive_user_id = $receive;
                    // $update->sjp_id = $request->sjp_id;
                    

                    $update->good_pallet = $goodpalletrcv;
                    $update->tbr_pallet = $tbr_palletrcv;
                    $update->ber_pallet = $ber_palletrcv;
                    $update->missing_pallet = $missing_palletrcv;
                    // $update->good_cement = $request->good_cement;
                    // $update->bad_cement = $request->bad_cement;
                    $update->transaction_id = 2;
                    $update->note = $request->note;
                    $update->status = 1;
                    $update->save();

                    $InventoryDest = PoolPallet::find($destination_id);
                    $InventoryDest->good_pallet = (($InventoryDest->good_pallet)+($goodpalletrcv)); //hanya receive good pallet
                    $InventoryDest->tbr_pallet = (($InventoryDest->tbr_pallet)+($tbr_palletrcv)); 
                    // $InventoryDest->ber_pallet = (($InventoryDest->ber_pallet)+($request->ber_pallet)); // ber & missing dicatat di transporter
                    // $InventoryDest->missing_pallet = (($InventoryDest->missing_pallet)+($request->missing_pallet)); // ber & missing dicatat di transporter
                    $InventoryDest->save();

                    $InventoryTrans = Transporter::find($transporter_id);
                    if($tbr_pallet_awal==0){ //jika saat send tidak terdapat tbr pallet   
                        if($missing_ber>0){
                            $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($missing_ber+$request->good_pallet));
                            $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)+($request->ber_pallet)); 
                            $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)+($request->missing_pallet));
                        }
                        else{
                            $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($good_pallet_awal));    
                        }
                        
                       
                    }
                    else if(($request->tbr_pallet)>$tbr_pallet_awal || ($request->tbr_pallet)!=$tbr_pallet_awal ){ //jika rcv tbr pallet lebih besar dari yang di send
                        if($missing_ber>0){
                            $selisihtbr = ($request->tbr_pallet)-$tbr_pallet_awal;
                            $selisihgood = $good_pallet_awal-($request->good_pallet);
                            if($selisihgood==$selisihtbr){
                                $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)-($selisihtbr+$missing_ber));
                                $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($selisihgood+$missing_ber));
                                $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)+($request->ber_pallet)); 
                                $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)+($request->missing_pallet));
                            }
                        }
                        else{
                            $selisihtbr = ($request->tbr_pallet)-$tbr_pallet_awal;
                            $selisihgood = $good_pallet_awal-($request->good_pallet);
                            if($selisihgood==$selisihtbr){
                                $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)-($tbr_pallet_awal));
                                $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($good_pallet_awal));
                            } 
                        }
                        
                    }
                    else{
                        $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($request->good_pallet));
                        $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)-($request->tbr_pallet));
                        $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)+($request->ber_pallet)); 
                        $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)+($request->missing_pallet));
                    }
                    // $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($good_pallet_awal));
                    // $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)-($request->tbr_pallet)); 
                    $InventoryTrans->save();

                    // Membuat log all transaksi send
                    $receiver = Auth::user()->name;
                    $sjp_id = $sjp->sjp_id;
                    $sjps_number = 'RECEIVE';
                    $palletsenddept = PoolPallet::find($departure_id);
                    $palletsenddest = PoolPallet::find($destination_id);
                    $palletsendtrans = Transporter::find($transporter_id);
                    $palletsenddriver = Driver::find($driver_id);
                    $palletsendvehicle = Vehicle::find($vehicle_id);
                    $alltransaction = Alltransaction::create([
                        'reference_sjp_id' => $sjp_id,
                        'reference_sjp_status_id' => $sjpStatus->sjp_status_id,
                        'transaction' => 'SJP Status Receive Sendback',
                        'status' => 'RECEIVE SENDBACK',
                        'no_do' => $sjp->no_do,
                        'receiver/approver' => $receiver,
                        'departure_pool' => $palletsenddept->pool_name, 
                        'destination_pool' => $palletsenddest->pool_name,
                        'transporter' => $palletsendtrans->transporter_name,
                        'driver' => $palletsenddriver->driver_name,
                        'vehicle' => $palletsendvehicle->vehicle_number,
                        'good_pallet' => $request->good_pallet, 
                        'note' => $request->note,
                        'tbr_pallet' => $request->tbr_pallet, 
                        'ber_pallet' => $request->ber_pallet, 
                        'missing_pallet' => $request->missing_pallet, 
                        'good_cement' => 0,
                        'bad_cement' => 0,
                        'note' => $request->note
                    ]);


                    // Membuat log transaksi Receive
                    $receiver = Auth::user()->name;
                    $sjp_number = $sjp->sjp_number;
                    $sjps_number = 'RECEIVE SENDBACK';
                    $palletsenddept = PoolPallet::find($departure_id);
                    $palletsenddest = PoolPallet::find($destination_id);
                    $palletsendtrans = Transporter::find($transporter_id);
                    $palletsenddriver = Driver::find($driver_id);
                    $palletsendvehicle = Vehicle::find($vehicle_id);
                    $Sjpreceive = Sjppalletreceive::create([
                        'sjp_status_id' => $sjpStatus->sjp_status_id,
                        'sjp_number' => $sjp_number,
                        'sjp_status' => $sjps_number,
                        'receiver' => $receiver,
                        'departure_pool' => $palletsenddept->pool_name, 
                        'destination_pool' => $palletsenddest->pool_name,
                        'transporter' => $palletsendtrans->transporter_name,
                        'driver' => $palletsenddriver->driver_name,
                        'vehicle' => $palletsendvehicle->vehicle_number,
                        'good_pallet' => $request->good_pallet, 
                        'tbr_pallet' => $request->tbr_pallet, 
                        'ber_pallet' => $request->ber_pallet, 
                        'missing_pallet' => $request->missing_pallet, 
                        // 'good_cement' => $request->good_cement,
                        // 'bad_cement' => $request->bad_cement,
                        'note' => $request->note,
                    ]);
                    
                    //membuat ber missing pallet record ketika ada pallet ber/missing
                    if(($request->ber_pallet)>0 || ($request->missing_pallet>0)){
                        $receive = Auth::user()->id;
                        $Bermissing = Bermissing::create([
                            'reporter_user_id' => $receive, 
                            'approver_user_id' => 5, 
                            'transporter_id' => $transporter_id,
                            'reference_sjp_status_id' => $sjp_status_id,
                            'ber_pallet' => $request->ber_pallet, 
                            'missing_pallet' => $request->missing_pallet,
                            'status' => 0,
                            'note' => 'TERDAPAT PALLET YANG BER/HILANG SAAT RECEIVE OLEH CHECKER',  
                        ]);
                        
                        $reporter = Auth::user()->name;
                        $sjps_number    = $update->sjps_number;
                        $palletbermissingpool = PoolPallet::find($departure_id);
                        $palletbermissingtrans = Transporter::find($transporter_id);
                        $transporterbermissing = $palletbermissingtrans->transporter_name;
                        $Bermissingreported = Bermissingreported::create([
                            'ber_missing_id' => $Bermissing->ber_missing_pallet_id,
                            'reporter' => $reporter, 
                            'pool_pallet' => 5, 
                            'transporter_id' => $palletbermissingtrans->transporter_name,
                            'reference_sjp_status_id' => $sjps_number,
                            'ber_pallet' => $request->ber_pallet, 
                            'missing_pallet' => $request->missing_pallet,
                            'status' => 0,
                            'note' => 'TERDAPAT PALLET YANG BER/HILANG SAAT RECEIVE OLEH CHECKER',  
                        ]);
                    }
                    // if(($request->tbr_pallet)>0){
                    //     $Damage = Damagedpallet::create([
                    //         'reporter_user_id' => $request->checker_receive_user_id, 
                    //         'transporter_id' => $transporter_id,
                    //         'reference_sjp_status_id' => $sjp_status_id,
                    //         'tbr_pallet' => $request->tbr_pallet, 
                    //         'note' => 'PALLET RUSAK/TBR DITEMUKAN SAAT RECEIVE OLEH CHECKER',  
                    //     ]);
                    // }
                    $status = 'CLOSED';
                    $Sjpstat = Sjp::find($sjp_id);
                    $Sjpstat->status = $status;
                    $Sjpstat->save();

                    $state = Sjp::find($sjp_id);
                    $state->state=4;
                    $state->save();


                    DB::commit();
                    return response()->json(['status' => 'success'], 200);
                }
                
                // $data = [
                //     'data' => $sjpStatus,
                //     'status' => (bool) $sjpStatus,
                //     'message' => $sjpStatus ? 'SJP Status Record Created!' : 'Error Creating SJP Status Record' 
                // ];

                // return response()->json($data);
                } catch (\Exception $e) {
                    DB::rollback();
                    return response()->json([
                        'status' => 'error', 
                        'data' => $e->getMessage(),
                        'message' => 'Error SJP Status Receive Sendback Record'], 422);
                }      
            
        }    
    }
   

    public function destroy($id)
    {
        $sjpstatus = SjpStatus::find($id); //QUERY DATA BERDASARKAN ID
        $sjpstatus->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}