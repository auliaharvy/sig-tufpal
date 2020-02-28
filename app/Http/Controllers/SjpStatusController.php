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
use DB;

class SjpStatusController extends Controller
{
    public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        if($pool_pallet==null){
        $sjpstatus = DB::table('sjp_status as a')
            ->join('users as b', 'a.checker_send_user_id', '=', 'b.id')
            ->join('users as c', 'a.checker_receive_user_id', '=', 'c.id')
            ->join('surat_jalan_pallet as d', 'a.sjp_id', '=', 'd.sjp_id')
            ->join('mst_transaction as e', 'a.transaction_id', '=', 'e.id')
            ->select('a.*', 'b.name as checker_sender', 'c.name as checker_receiver',
                    'd.sjp_number','e.transaction')            
            ->paginate(10)
            ->toArray();
        }
        else{
            $sjpstatus = DB::table('sjp_status as a')
            ->join('users as b', 'a.checker_send_user_id', '=', 'b.id')
            ->join('users as c', 'a.checker_receive_user_id', '=', 'c.id')
            ->join('surat_jalan_pallet as d', 'a.sjp_id', '=', 'd.sjp_id')
            ->join('mst_transaction as e', 'a.transaction_id', '=', 'e.id')
            ->select('a.*', 'b.name as checker_sender', 'c.name as checker_receiver',
                    'd.sjp_number','e.transaction')
            ->where('d.departure_pool_pallet_id',$pool_pallet)
            ->orWhere('d.destination_pool_pallet_id', $pool_pallet)
            
            ->paginate(10)
            ->toArray();
        }
        // // $sjp = new SjpCollection($sjp1);
        return $sjpstatus;
        // $sjpstatus = new SjpStatusCollection(SjpStatus::paginate(10));
		//  return $sjpstatus;
        // return response()->json(Sjp::all()->toArray());
    }

    public function show($sjp_status_id)
    {
        $sjpstatus = SjpStatus::find($sjp_status_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $sjpstatus]);
    }

    public function store(Request $request)
    {
        $sjp_id = $request->sjp_id;
        $sjp_status_id = $request->sjp_status_id;
        $sjp = DB::table('surat_jalan_pallet')->where('sjp_id',$sjp_id)->first();
        $transporter_id = $sjp->transporter_id;
        
        if(($request->transaction_id)==1){ //send pool to wh
            $departure_id = $sjp->departure_pool_pallet_id;
            $destination_id = $sjp->destination_pool_pallet_id;
        }
        else{ //statuss = 2 or send wh to pool
            $destination_id = $sjp->departure_pool_pallet_id;
            $departure_id = $sjp->destination_pool_pallet_id;
        }

        $sjpStatus = SjpStatus::create([
            'checker_send_user_id' => $request->checker_send_user_id, 
            'checker_receive_user_id' => 5, 
            'sjp_id' => $request->sjp_id,
            'good_pallet' => $request->good_pallet, 
            'tbr_pallet' => $request->tbr_pallet, 
            'ber_pallet' => $request->ber_pallet, 
            'missing_pallet' => $request->missing_pallet, 
            'good_cement' => $request->good_cement, 
            'bad_cement' => $request->bad_cement, 
            'updated_at' => $request->updated_at,
            'transaction_id' => $request->transaction_id,
            'note' => $request->note, 
            'status' => 'SENDING',
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

        $data = [
            'data' => $sjpStatus,
            'status' => (bool) $sjpStatus,
            'message' => $sjpStatus ? 'SJP Status Record Created!' : 'Error Creating SJP Status Record' 
        ];

        return response()->json($data);
    }

    public function receive(Request $request)
    {
        $sjp_id = $request->sjp_id;
        $sjp_status_id = $request->sjp_status_id;
        $sjp = DB::table('surat_jalan_pallet')->where('sjp_id',$sjp_id)->first();
        $transporter_id = $sjp->transporter_id;
       

        if(($request->transaction_id)==1){ //send 
            $departure_id = $sjp->departure_pool_pallet_id;
            $destination_id = $sjp->destination_pool_pallet_id;
            $status = $sjp->status;
        }
        else{ //statuss = 2 or send back
            
            $status = 'CLOSED';
            $destination_id = $sjp->departure_pool_pallet_id;
            $departure_id = $sjp->destination_pool_pallet_id;

        }

        $sjpStatus = SjpStatus::where('sjp_status_id',$sjp_status_id)->first();
        if (empty($sjpStatus)){
            return response()->json(['error' => 'Data not found'], 404);
        }
        else{
            $update = SjpStatus::find($sjp_status_id);
            $good_pallet_awal = $update->good_pallet; //ambil qty pallet awal
            $ber_pallet_awal = $update->ber_pallet; //ambil qty pallet awal
            $missing_pallet_awal = $update->missing_pallet; //ambil qty pallet awal

            $update->checker_send_user_id = $request->checker_send_user_id;
            $update->checker_receive_user_id = $request->checker_receive_user_id;
            $update->sjp_id = $request->sjp_id;
            $update->good_pallet = $request->good_pallet;
            $update->tbr_pallet = $request->tbr_pallet;
            $update->ber_pallet = $request->ber_pallet;
            $update->missing_pallet = $request->missing_pallet;
            $update->good_cement = $request->good_cement;
            $update->bad_cement = $request->bad_cement;
            $update->transaction_id = $request->transaction_id;
            $update->note = $request->note;
            $update->status = 'RECEIVED';
            $update->save();

            $InventoryDest = PoolPallet::find($destination_id);
            $InventoryDest->good_pallet = (($InventoryDest->good_pallet)+($request->good_pallet)); //hanya receive good pallet
            $InventoryDest->tbr_pallet = (($InventoryDest->tbr_pallet)+($request->tbr_pallet)); // ber & missing dicatat di transporter
            // $InventoryDest->ber_pallet = (($InventoryDest->ber_pallet)+($request->ber_pallet));
            // $InventoryDest->missing_pallet = (($InventoryDest->missing_pallet)+($request->missing_pallet));
            $InventoryDest->save();
            if(($request->ber_pallet)>0 || ($request->missing_pallet>0)){
                $Bermissing = Bermissing::create([
                    'reporter_user_id' => $request->checker_receive_user_id, 
                    'approver_user_id' => 5, 
                    'transporter_id' => $transporter_id,
                    'reference_sjp_status_id' => $sjp_status_id,
                    'ber_pallet' => $request->ber_pallet, 
                    'missing_pallet' => $request->missing_pallet,
                    'note' => 'PALLET RUSAK/HILANG DITEMUKAN SAAT RECEIVE OLEH CHECKER',  
                ]);
            }
            
            $InventoryTrans = Transporter::find($transporter_id);
            $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-($good_pallet_awal));
            $InventoryTrans->tbr_pallet = (($InventoryTrans->tbr_pallet)-($request->tbr_pallet)); //??
            $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)+($request->ber_pallet)); //setiap ada ber / missing masuk ke transporter
            $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)+($request->missing_pallet));
            $InventoryTrans->save();

            $Sjpstat = Sjp::find($sjp_id);
            $Sjpstat->status = $status;
            $Sjpstat->save();


        }

       

        $data = [
            'data' => $update,
            'status' => (bool) $update,
            'message' => $update ? 'SJP Status Record Updated!' : 'Error Updating SJP Status Record' 
        ];

        return response()->json($data);
    }

    public function destroy($id)
    {
        $sjpstatus = SjpStatus::find($id); //QUERY DATA BERDASARKAN ID
        $sjpstatus->delete(); //KEMUDIAN HAPUS DATA TERSEBUT
        return response()->json(['status' => 'success']);
    }
}
