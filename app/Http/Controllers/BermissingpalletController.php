<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Resources\BermissingpalletCollection;
use Illuminate\Support\Facades\Auth;
use App\Bermissing;
use App\SjpStatus;
use App\Transporter;
use App\PoolPallet;
use App\Bermissingreported;
use App\Bermissingapproved;
use DB;

class BermissingpalletController extends Controller
{
    public function index()
    {
        // $sjp = new SjpCollection(Sjp::paginate(10));
		//  return $sjp;
        // return response()->json(Sjp::all()->toArray());
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $role = Auth::user()->role;
        if($pool_pallet==1 && $role<7){
            $bermissing = DB::table('ber_missing_pallet as a')
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->join('users as c', 'a.approver_user_id', '=', 'c.id')
            ->leftJoin('pool_pallet as d', 'a.pool_pallet_id', '=', 'd.pool_pallet_id')
            ->leftJoin('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
            ->leftJoin('sjp_status as f', 'a.reference_sjp_status_id', '=', 'f.sjp_status_id')
            ->select('a.*', 'b.name as reporter', 'c.name as approver',
                    'd.pool_name','e.transporter_name', 'f.sjps_number')
            ->where('a.status',1)
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $bermissing = DB::table('ber_missing_pallet as a')
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->join('users as c', 'a.approver_user_id', '=', 'c.id')
            ->leftJoin('pool_pallet as d', 'a.pool_pallet_id', '=', 'd.pool_pallet_id')
            ->leftJoin('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
            ->leftJoin('sjp_status as f', 'a.reference_sjp_status_id', '=', 'f.sjp_status_id')
            ->select('a.*', 'b.name as reporter', 'c.name as approver',
                    'd.pool_name','e.transporter_name', 'f.sjps_number')
            ->where('a.pool_pallet_id',$pool_pallet)
            ->where('a.status',1)
            ->paginate(10000000)
            ->toArray();
        }
        
       
        return $bermissing;
        // //return response()->json(Bermissing::all()->toArray());a
    }

    public function show($ber_missing_pallet_id)
    {
        $bermissing = Bermissing::find($ber_missing_pallet_id); //MELAKUKAN QUERY UNTUK MENGAMBIL DATA BERDASARKAN ID
        return response()->json(['status' => 'success', 'data' => $bermissing]);
    }

    public function store(Request $request)
    {
        $ber_missing_pallet_id = $request->ber_missingPallet_id;
        $pool_pallet_id = Auth::user()->reference_pool_pallet_id;
        $transporter_id = Auth::user()->reference_transporter_id;
        // $InventoryPool = PoolPallet::find($pool_pallet_id);
        // $InventoryTrans = Transporter::find($transporter_id);
        // if($pool_pallet_id!=null){
        //     $InventoryPool = PoolPallet::find($pool_pallet_id);
        //     $palletpool = $InventoryPool->good_pallet;
        // }
        // if($transporter_id!=null){
        //     $InventoryTrans = Transporter::find($transporter_id);
        //     $pallettrans = $InventoryTrans->good_pallet;
        // }  

        if($pool_pallet_id!=null){
            $InventoryPool = PoolPallet::find($pool_pallet_id);
            $palletpool = $InventoryPool->good_pallet;
            $this->validate($request, [
                // 'good_pallet' => 'required|integer|gt:-1|lte:'.$pallet_qty,
                // 'tbr_pallet' => 'required|integer|gt:-1',
                'ber_pallet' => 'required|integer|gt:-1|lte:'.$palletpool,
                'missing_pallet' => 'required|integer|gt:-1|lte:'.$palletpool,
                // 'good_cement' => 'required|integer|gt:-1|lte:'.$cement_qty,
                // 'bad_cement' => 'required|integer|gt:-1'
                ]);
        }
        if($transporter_id!=null){
            $InventoryTrans = Transporter::find($transporter_id);
            $pallettrans = $InventoryTrans->good_pallet;
            $this->validate($request, [
                // 'good_pallet' => 'required|integer|gt:-1|lte:'.$pallet_qty,
                // 'tbr_pallet' => 'required|integer|gt:-1',
                'ber_pallet' => 'required|integer|gt:-1|lte:'.$pallettrans,
                'missing_pallet' => 'required|integer|gt:-1|lte:'.$pallettrans,
                // 'good_cement' => 'required|integer|gt:-1|lte:'.$cement_qty,
                // 'bad_cement' => 'required|integer|gt:-1'
                ]);
        }

        $bermissing = Bermissing::create([
            'reporter_user_id' => auth()->user()->id,
            'approver_user_id' => 5,
            'pool_pallet_id' => auth()->user()->reference_pool_pallet_id, 
            'transporter_id' => auth()->user()->reference_transporter_id, 
            'ber_pallet' => $request->ber_pallet, 
            'missing_pallet' => $request->missing_pallet, 
            'reporter_prove' => $request->reporter_prove,
            'berita_acara' => $request->berita_acara,
            'status' => 0,
            'note' => $request->note, 
        ]);
        
        
         // Membuat log transaksi report ber missing
         if($pool_pallet_id!=null){
            $reporter = Auth::user()->name;
            $pool_pallet_id = Auth::user()->reference_pool_pallet_id;
            $transporter_id = Auth::user()->reference_transporter_id;
            $bermissingreportpool = PoolPallet::find($pool_pallet_id);
            // $bermissingreporttrans = Transporter::find($transporter_id);
            $bermissingreported = Bermissingreported::create([
                'reporter' => $reporter,
                'pool_pallet' => $bermissingreportpool->pool_name,
                // 'transporter' => $bermissingreporttrans->transporter_name,
                'reference_sjp_status' => 5,
                'ber_pallet' => $request->ber_pallet,
                'missing_pallet' => $request->missing_pallet,
                'prove' => $request->reporter_prove,
                'berita_acara' => $request->berita_acara,
                'note' => $request->note,
            ]);
         }

         if($transporter_id!=null){
            $reporter = Auth::user()->name;
            $pool_pallet_id = Auth::user()->reference_pool_pallet_id;
            $transporter_id = Auth::user()->reference_transporter_id;
            // $bermissingreportpool = PoolPallet::find($pool_pallet_id);
            $bermissingreporttrans = Transporter::find($transporter_id);
            $bermissingreported = Bermissingreported::create([
                'reporter' => $reporter,
                // 'pool_pallet' => $bermissingreportpool->pool_name,
                'transporter' => $bermissingreporttrans->transporter_name,
                'reference_sjp_status' => 5,
                'ber_pallet' => $request->ber_pallet,
                'missing_pallet' => $request->missing_pallet,
                'prove' => $request->reporter_prove,
                'berita_acara' => $request->berita_acara,
                'note' => $request->note,
            ]);
         }

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
        $pool_pallet_id = Auth::user()->reference_pool_pallet_id;
        $transporter_id = Auth::user()->reference_transporter_id;
        // $InventoryPool = PoolPallet::find($pool_pallet_id);
        // $InventoryTrans = Transporter::find($transporter_id);
        // $InventoryPool = PoolPallet::find($pool_pallet_id);
        // $InventoryTrans = Transporter::find($transporter_id);
        // $palletpool = $InventoryPool->good_pallet;
        // $pallettrans = $InventoryTrans->good_pallet;


        if($pool_pallet_id!=null){
            $InventoryPool = PoolPallet::find($pool_pallet_id);
            $palletpool = $InventoryPool->good_pallet;
            $this->validate($request, [
                // 'good_pallet' => 'required|integer|gt:-1|lte:'.$pallet_qty,
                // 'tbr_pallet' => 'required|integer|gt:-1',
                'ber_pallet' => 'required|integer|gt:-1|lte:'.$palletpool,
                'missing_pallet' => 'required|integer|gt:-1|lte:'.$palletpool,
                // 'good_cement' => 'required|integer|gt:-1|lte:'.$cement_qty,
                // 'bad_cement' => 'required|integer|gt:-1'
                ]);
        }
        if($transporter_id!=null){
            $InventoryTrans = Transporter::find($transporter_id);
            $pallettrans = $InventoryTrans->good_pallet;
            $this->validate($request, [
                // 'good_pallet' => 'required|integer|gt:-1|lte:'.$pallet_qty,
                // 'tbr_pallet' => 'required|integer|gt:-1',
                'ber_pallet' => 'required|integer|gt:-1|lte:'.$pallettrans,
                'missing_pallet' => 'required|integer|gt:-1|lte:'.$pallettrans,
                // 'good_cement' => 'required|integer|gt:-1|lte:'.$cement_qty,
                // 'bad_cement' => 'required|integer|gt:-1'
                ]);
        }
        $bermissing = Bermissing::where('ber_missing_pallet_id',$ber_missing_pallet_id)->first();
        if (empty($bermissing)){
            return response()->json(['error' => 'Data not found'], 404);
        }
        else{
            $update = Bermissing::find($ber_missing_pallet_id);
            // $update->reporter_user_id = $request->reporter_user_id;
            $update->approver_user_id = auth()->user()->id;
            // $update->pool_pallet_id = $request->pool_pallet_id;
            // $update->transporter_id = $request->transporter_id;
            $update->ber_pallet = $request->ber_pallet;
            $update->missing_pallet = $request->missing_pallet; 
            $update->reporter_prove = $request->reporter_prove;
            $update->status = 1;
            $update->note = $request->note; 
            $update->save();


            // Membuat log transaksi report ber missing
            if($pool_pallet_id!=null){
                $approver = Auth::user()->name;
                $bermissingapprovpool = PoolPallet::find($pool_pallet_id);
                // $bermissingapprovtrans = Transporter::find($transporter_id);
                $bermissingapproved = Bermissingapproved::create([
                    'approver' => $approver,
                    'bmp_number' => $update->bmp_number,
                    'pool_pallet' => $bermissingapprovpool->pool_name,
                    // 'transporter' => $bermissingapprovtrans->transporter_name,
                    'reference_sjp_status' => $update->reference_sjp_status,
                    'ber_pallet' => $request->ber_pallet,
                    'missing_pallet' => $request->missing_pallet,
                    'prove' => $update->reporter_prove,
                    'berita_acara' => $request->berita_acara,
                    'note' => $request->note,
                ]);
            }

            if($transporter_id!=null){
                $approver = Auth::user()->name;
                // $bermissingapprovpool = PoolPallet::find($pool_pallet_id);
                $bermissingapprovtrans = Transporter::find($transporter_id);
                $bermissingapproved = Bermissingapproved::create([
                    'approver' => $approver,
                    'bmp_number' => $update->bmp_number,
                    // 'pool_pallet' => $bermissingapprovpool->pool_name,
                    'transporter' => $bermissingapprovtrans->transporter_name,
                    'reference_sjp_status' => $update->reference_sjp_status,
                    'ber_pallet' => $request->ber_pallet,
                    'missing_pallet' => $request->missing_pallet,
                    'prove' => $update->reporter_prove,
                    'berita_acara' => $request->berita_acara,
                    'note' => $request->note,
                ]);
            }

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
