<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use App\Http\Resources\BermissingpalletCollection;
use Illuminate\Support\Facades\Auth;
use Hashids\Hashids;
use App\Bermissing;
use App\SjpStatus;
use App\Transporter;
use App\PoolPallet;
use App\Alltransaction;
use App\Bermissingreported;
use App\Bermissingapproved;
use App\Bermissingdisapproved;
use App\User;
use App\DeletedItem;
use DB;

class BermissingpalletController extends Controller
{
    public function index()
    {
        $pool_pallet = Auth::user()->reference_pool_pallet_id;
        $transporter = Auth::user()->reference_transporter_id;
        $role = Auth::user()->role;
        if($pool_pallet=='pooldli' && $role<6){
            $bermissing = DB::table('ber_missing_pallet as a')
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->join('users as c', 'a.approver_user_id', '=', 'c.id')
            ->leftJoin('pool_pallet as d', 'a.pool_pallet_id', '=', 'd.pool_pallet_id')
            ->leftJoin('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
            ->leftJoin('sjp_status as f', 'a.reference_sjp_status_id', '=', 'f.sjp_status_id')
            ->select('a.*', 'b.name as reporter', 'c.name as approver',
                    'd.pool_name','e.transporter_name', 'f.sjps_number')
            ->where('a.status',0)
            ->paginate(10000000)
            ->toArray();
        }
        else{
            $bermissing = DB::table(DB::raw('(SELECT * FROM ber_missing_pallet WHERE status = 0)a'))
            ->join('users as b', 'a.reporter_user_id', '=', 'b.id')
            ->join('users as c', 'a.approver_user_id', '=', 'c.id')
            ->leftJoin('pool_pallet as d', 'a.pool_pallet_id', '=', 'd.pool_pallet_id')
            ->leftJoin('transporter as e', 'a.transporter_id', '=', 'e.transporter_id')
            ->leftJoin('sjp_status as f', 'a.reference_sjp_status_id', '=', 'f.sjp_status_id')
            ->select('a.*', 'b.name as reporter', 'c.name as approver',
                    'd.pool_name','e.transporter_name', 'f.sjps_number')
            ->where('a.pool_pallet_id',$pool_pallet)
            ->orWhere('a.transporter_id',$transporter)
            ->paginate(10000000)
            ->toArray();
        }
        return $bermissing;
    }

    public function show($ber_missing_pallet_id)
    {
        $bermissing = Bermissing::find($ber_missing_pallet_id);
        return response()->json(['status' => 'success', 'data' => $bermissing]);
    }

    public function edit($id)
    {
        $encryptid = Crypt::encrypt($id);
        // $hashids->encode($id);
        $bermissing = Bermissing::find($id);
        return response()->json(['status' => 'success', 'data' => $bermissing]);
    }

    public function view($ber_missing_pallet_id)
    {
        $hashids = new Hashids();
        $hashids->encode($ber_missing_pallet_id);

        $bermissing = Bermissing::find($ber_missing_pallet_id);
        $reporter_user_id = $bermissing->reporter_user_id;
        $approver_user_id = $bermissing->approver_user_id;
        $pool_pallet_id = $bermissing->pool_pallet_id;
        $transporter_id = $bermissing->transporter_id;
        $reference_sjp_status_id = $bermissing->reference_sjp_status_id;
        $user_reporter = User::find($reporter_user_id);
        $pool_pallet = PoolPallet::find($pool_pallet_id);
        $transporter = Transporter::find($transporter_id);
        $sjp_status = SjpStatus::find($reference_sjp_status_id);
        if($reference_sjp_status_id & $transporter_id != null){
            $sjps_number = $sjp_status->sjps_number;
            $transporter_name = $transporter->transporter_name;
            $pool_name = $pool_pallet->pool_name;
        }else{
            $sjps_number = null;
            $transporter_name = null;
            $pool_name = $pool_pallet->pool_name;
        }
        $data = [
            // 'sjps_number' =>$sjps_number,
            'bmp_number' => $bermissing->bmp_number,
            'ber_pallet' => $bermissing->ber_pallet,
            'missing_pallet' => $bermissing->missing_pallet,
            'reporter_prove' => $bermissing->reporter_prove,
            'note' => $bermissing->note,
            'status' => $bermissing->status,
            'pool_name' => $pool_name,
            'transporter_name' => $transporter_name,
            'sjps_number' => $sjps_number
        ];
        return response()->json(['status' => 'success', 'data' => $data]);
    }

    public function store(Request $request)
    {
        $ber_missing_pallet_id = $request->ber_missingPallet_id;
        $pool_pallet_id = $request->pool_pallet_id;
        $transporter_id = $request->transporter_id;
        if($pool_pallet_id != null){
            $InventoryPool = PoolPallet::find($pool_pallet_id);
            $palletpool = $InventoryPool->good_pallet;
            $this->validate($request, [
                'ber_pallet' => 'required|integer|gt:-1|lte:'.$palletpool,
                'missing_pallet' => 'required|integer|gt:-1|lte:'.$palletpool,
                ]);
        }elseif($transporter_id != null){
            $InventoryTrans = Transporter::find($transporter_id);
            $pallettrans = $InventoryTrans->good_pallet;
            $this->validate($request, [
                'ber_pallet' => 'required|integer|gt:-1|lte:'.$pallettrans,
                'missing_pallet' => 'required|integer|gt:-1|lte:'.$pallettrans,
                'reporter_prove' => 'required|image'

                ]);
        }
        DB::beginTransaction();
        try{
            $name = NULL;
                if ($request->hasFile('reporter_prove')) {
                    $file = $request->file('reporter_prove');
                    $name = 'reporter_prove' . '-' . time() . '.' . $file->getClientOriginalExtension();
                    $file->storeAs('public/bermissing/reporter_prove', $name);
                }
            $bermissing = Bermissing::create([
                'reporter_user_id' => auth()->user()->id,
                'approver_user_id' => 5,
                'pool_pallet_id' => $pool_pallet_id,
                'transporter_id' => $transporter_id,
                // 'reference_sjp_status' => null,
                'ber_pallet' => $request->ber_pallet,
                'missing_pallet' => $request->missing_pallet,
                'reporter_prove' => $name,
                // 'berita_acara' => $request->berita_acara,
                'status' => 0,
                'note' => $request->note,
            ]);

            // Membuat log All Transaction
            if($pool_pallet_id!=null){
                $reporter = Auth::user()->name;
                $pool_pallet_id = $pool_pallet_id;
                $transporter_id = $transporter_id;
                $bermissingreportpool = PoolPallet::find($pool_pallet_id);
                // $bermissingreporttrans = Transporter::find($transporter_id);
                $alltransaction = Alltransaction::create([
                    'reference_ber_missing_id' => $bermissing->ber_missing_pallet_id,
                    'sender/reporter' => $reporter,
                    'transaction' => 'BER/Missing Pallet Report',
                    'status' => 'REPORTED',
                    'pool_pallet' => $bermissingreportpool->pool_name,
                    // 'transporter' => $bermissingreporttrans->transporter_name,
                    'ber_pallet' => $request->ber_pallet,
                    'missing_pallet' => $request->missing_pallet,
                    'reporter_prove' => $name,
                    'note' => $request->note,
                ]);
            }
            elseif($transporter_id!=null){
                $reporter = Auth::user()->name;
                $pool_pallet_id = $pool_pallet_id;
                $transporter_id = $transporter_id;
                // $bermissingreportpool = PoolPallet::find($pool_pallet_id);
                $bermissingreporttrans = Transporter::find($transporter_id);
                $alltransaction = Alltransaction::create([
                    'reference_ber_missing_id' => $bermissing->ber_missing_pallet_id,
                    'sender/reporter' => $reporter,
                    'status' => 'REPORTED',
                    // 'pool_pallet' => $bermissingreportpool->pool_name,
                    'transporter' => $bermissingreporttrans->transporter_name,
                    'ber_pallet' => $bermissing->ber_pallet,
                    'missing_pallet' => $bermissing->missing_pallet,
                    'reporter_prove' => $name,
                    'note' => $request->note,
                ]);
            }

            // Membuat log transaksi report ber missing
            if($pool_pallet_id!=null){
                $reporter = Auth::user()->name;
                $pool_pallet_id = $pool_pallet_id;
                $transporter_id = $transporter_id;
                $bermissingreportpool = PoolPallet::find($pool_pallet_id);
                // $bermissingreporttrans = Transporter::find($transporter_id);
                $bermissingreported = Bermissingreported::create([
                    'reporter' => $reporter,
                    'ber_missing_id' => $bermissing->ber_missing_pallet_id,
                    'status' => 'REPORTED',
                    'pool_pallet' => $bermissingreportpool->pool_name,
                    // 'transporter' => $bermissingreporttrans->transporter_name,
                    // 'reference_sjp_status' => 5,
                    'ber_pallet' => $bermissing->ber_pallet,
                    'missing_pallet' => $bermissing->missing_pallet,
                    'reporter_prove' => $name,
                    'note' => $request->note,
                ]);
            }
            elseif($transporter_id!=null){
                $reporter = Auth::user()->name;
                $pool_pallet_id = $pool_pallet_id;
                $transporter_id = $transporter_id;
                // $bermissingreportpool = PoolPallet::find($pool_pallet_id);
                $bermissingreporttrans = Transporter::find($transporter_id);
                $bermissingreported = Bermissingreported::create([
                    'reporter' => $reporter,
                    'ber_missing_id' => $bermissing->ber_missing_pallet_id,
                    'status' => 'REPORTED',
                    // 'pool_pallet' => $bermissingreportpool->pool_name,
                    'transporter' => $bermissingreporttrans->transporter_name,
                    // 'reference_sjp_status' => 5,
                    'ber_pallet' => $bermissing->ber_pallet,
                    'missing_pallet' => $bermissing->missing_pallet,
                    'reporter_prove' => $name,
                    'note' => $request->note,
                ]);
            }

            //DB Transaction Pallet
            if($pool_pallet_id!=null){
                $InventoryPool = PoolPallet::find($pool_pallet_id);
                $InventoryPool->good_pallet = (($InventoryPool->good_pallet)-(($request->ber_pallet)+($request->missing_pallet)));
                $InventoryPool->ber_pallet = (($InventoryPool->ber_pallet)+($request->ber_pallet));
                $InventoryPool->missing_pallet = (($InventoryPool->missing_pallet)+($request->missing_pallet));
                $InventoryPool->save();
            }
            elseif($transporter_id!=null){
                $InventoryTrans = Transporter::find($transporter_id);
                $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)-(($request->ber_pallet)+($request->missing_pallet)));
                $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)+($request->ber_pallet));
                $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)+($request->missing_pallet));
                $InventoryTrans->save();
            }

            DB::commit();
            return response()->json(['status' => 'success'], 200);
        } catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Created BER/Missing Pallet Record'], 422);
        }
    }

    public function approve(Request $request)
    {
        $ber_missing_pallet_id = $request->ber_missing_pallet_id;
        $update = Bermissing::find($ber_missing_pallet_id);
        $pool_pallet_id = $update->pool_pallet_id;
        $transporter_id = $update->transporter_id;

        if($pool_pallet_id!=null){
            $update = Bermissing::find($ber_missing_pallet_id);
            $updateberpallet = $update->ber_pallet;
            $updatemissingpallet = $update->missing_pallet;

            $this->validate($request, [
                'ber_pallet' => 'required|integer|gt:-1|lte:'.$updateberpallet,
                'missing_pallet' => 'required|integer|gt:-1|lte:'.$updatemissingpallet,
                ]);
        }
        elseif($transporter_id!=null){
            $update = Bermissing::find($ber_missing_pallet_id);
            $updateberpallet = $update->ber_pallet;
            $updatemissingpallet = $update->missing_pallet;

            $this->validate($request, [
                'ber_pallet' => 'required|integer|gt:-1|lte:'.$updateberpallet,
                'missing_pallet' => 'required|integer|gt:-1|lte:'.$updatemissingpallet,
                ]);
        }
        DB::beginTransaction();
            try{
                $name = NULL;
                if ($request->hasFile('berita_acara')) {
                    $file = $request->file('berita_acara');
                    $name = 'berita_acara' . '-' . time() . '.' . $file->getClientOriginalExtension();
                    $file->storeAs('public/bermissing/berita_acara', $name);
                }

                $update = Bermissing::find($ber_missing_pallet_id);
                // $update->reporter_user_id = $request->reporter_user_id;
                $update->approver_user_id = auth()->user()->id;
                // $update->pool_pallet_id = $request->pool_pallet_id;
                // $update->transporter_id = $request->transporter_id;
                $update->ber_pallet = $request->ber_pallet;
                $update->missing_pallet = $request->missing_pallet;
                $update->berita_acara = $name;
                $update->status = 1;
                $update->note = $request->note;
                $update->save();


                // Membuat log all transaction
                if($pool_pallet_id!=null){
                    $approver = Auth::user()->name;
                    $bermissingapprovpool = PoolPallet::find($pool_pallet_id);
                    // $bermissingapprovtrans = Transporter::find($transporter_id);
                    $alltransaction = Alltransaction::create([
                        'reference_ber_missing_id' => $update->ber_missing_pallet_id,
                        'transaction' => 'BER/Missing Pallet Approve',
                        'receiver/approver' => $approver,
                        'status' => 'APPROVED',
                        'pool_pallet' => $bermissingapprovpool->pool_name,
                        'reference_sjp_status_id' => $update->reference_sjp_status,
                        // 'transporter' => $bermissingreporttrans->transporter_name,
                        'ber_pallet' => $request->ber_pallet,
                        'missing_pallet' => $request->missing_pallet,
                        'reporter_prove' => $update->reporter_prove,
                        'note' => $request->note,
                    ]);
                }
                elseif($transporter_id!=null){
                    $approver = Auth::user()->name;
                    // $bermissingapprovpool = PoolPallet::find($pool_pallet_id);
                    $bermissingapprovtrans = Transporter::find($transporter_id);
                    $alltransaction = Alltransaction::create([
                        'reference_ber_missing_id' => $update->ber_missing_pallet_id,
                        'receiver/approver' => $approver,
                        'status' => 'APPROVED',
                        // 'pool_pallet' => $bermissingapprovpool->pool_name,
                        'reference_sjp_status_id' => $update->reference_sjp_status,
                        'transporter' => $bermissingreporttrans->transporter_name,
                        'ber_pallet' => $request->ber_pallet,
                        'missing_pallet' => $request->missing_pallet,
                        'reporter_prove' => $update->reporter_prove,
                        'note' => $request->note,
                    ]);
                }

                // Membuat log transaksi report ber missing
                if($pool_pallet_id!=null){
                    $approver = Auth::user()->name;
                    $bermissingapprovpool = PoolPallet::find($pool_pallet_id);
                    // $bermissingapprovtrans = Transporter::find($transporter_id);
                    $bermissingapproved = Bermissingapproved::create([
                        'approver' => $approver,
                        'ber_missing_id' => $update->ber_missing_pallet_id,
                        'status' => 'APPROVED',
                        'pool_pallet' => $bermissingapprovpool->pool_name,
                        // 'transporter' => $bermissingapprovtrans->transporter_name,
                        'reference_sjp_status' => $update->reference_sjp_status,
                        'ber_pallet' => $request->ber_pallet,
                        'missing_pallet' => $request->missing_pallet,
                        'reporter_prove' => $update->reporter_prove,
                        'berita_acara' => $name,
                        'note' => $request->note,
                    ]);
                }
                elseif($transporter_id!=null){
                    $approver = Auth::user()->name;
                    // $bermissingapprovpool = PoolPallet::find($pool_pallet_id);
                    $bermissingapprovtrans = Transporter::find($transporter_id);
                    $bermissingapproved = Bermissingapproved::create([
                        'approver' => $approver,
                        'ber_missing_id' => $update->ber_missing_pallet_id,
                        'status' => 'APPROVED',
                        // 'pool_pallet' => $bermissingapprovpool->pool_name,
                        'transporter' => $bermissingapprovtrans->transporter_name,
                        'reference_sjp_status' => $update->reference_sjp_status,
                        'ber_pallet' => $request->ber_pallet,
                        'missing_pallet' => $request->missing_pallet,
                        'reporter_prove' => $update->reporter_prove,
                        'berita_acara' => $name,
                        'note' => $request->note,
                    ]);
                }

                if($pool_pallet_id!=null){
                    $selisihber = ($request->ber_pallet)-($update->ber_pallet);
                    $selisihmissing = ($request->missing_pallet)-($update->missing_pallet);
                    $InventoryPool = PoolPallet::find($pool_pallet_id);
                    $InventoryPool->ber_pallet = (($InventoryPool->ber_pallet)-($request->ber_pallet)+($selisihber));
                    $InventoryPool->missing_pallet = (($InventoryPool->missing_pallet)-($request->missing_pallet)+($selisihmissing));
                    $InventoryPool->save();
                }
                elseif($transporter_id!=null){
                    $selisihber = ($request->ber_pallet)-($update->ber_pallet);
                    $selisihmissing = ($request->missing_pallet)-($update->missing_pallet);
                    $InventoryTrans = Transporter::find($transporter_id);
                    $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)-($request->ber_pallet)+($selisihber));
                    $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)-($request->missing_pallet)+($selisihber));
                    $InventoryTrans->save();
                }

                DB::commit();
                return response()->json(['status' => 'success'], 200);

            }catch (\Exception $e) {
                DB::rollback();
                return response()->json([
                    'status' => 'error',
                    'data' => $e->getMessage(),
                    'message' => 'Error Approve BER/Missing Pallet Record'], 422);
            }
    }

    public function disapprove(Request $request)
    {
        $ber_missing_pallet_id = $request->ber_missing_pallet_id;
        $update = Bermissing::find($ber_missing_pallet_id);
        $pool_pallet_id = $update->pool_pallet_id;
        $transporter_id = $update->transporter_id;


        if($pool_pallet_id!=null){
            $update = Bermissing::find($ber_missing_pallet_id);
            $updateberpallet = $update->ber_pallet;
            $updatemissingpallet = $update->missing_pallet;

            $this->validate($request, [
                'ber_pallet' => 'required|integer|gt:-1|lte:'.$updateberpallet,
                'missing_pallet' => 'required|integer|gt:-1|lte:'.$updatemissingpallet,
                ]);
        }
        elseif($transporter_id!=null){
            $update = Bermissing::find($ber_missing_pallet_id);
            $updateberpallet = $update->ber_pallet;
            $updatemissingpallet = $update->missing_pallet;
            $this->validate($request, [
                'ber_pallet' => 'required|integer|gt:-1|lte:'.$updateberpallet,
                'missing_pallet' => 'required|integer|gt:-1|lte:'.$updatemissingpallet,
                ]);
        }

        DB::beginTransaction();
        try{
            $update = Bermissing::find($ber_missing_pallet_id);
            // $update->reporter_user_id = $request->reporter_user_id;
            $update->approver_user_id = auth()->user()->id;
            // $update->pool_pallet_id = $request->pool_pallet_id;
            // $update->transporter_id = $request->transporter_id;
            $update->ber_pallet = $request->ber_pallet;
            $update->missing_pallet = $request->missing_pallet;
            $update->reporter_prove = $request->reporter_prove;
            $update->status = 2;
            $update->note = $request->note;
            $update->save();


            // Membuat log all transaction
            if($pool_pallet_id!=null){
                $approver = Auth::user()->name;
                $bermissingapprovpool = PoolPallet::find($pool_pallet_id);
                // $bermissingapprovtrans = Transporter::find($transporter_id);
                $alltransaction = Alltransaction::create([
                    'reference_ber_missing_id' => $update->ber_missing_pallet_id,
                    'transaction' => 'BER/Missing Pallet Disapprove',
                    'receiver/approver' => $approver,
                    'status' => 'DISAPPROVED',
                    'pool_pallet' => $bermissingapprovpool->pool_name,
                    'reference_sjp_status_id' => $update->reference_sjp_status,
                    // 'transporter' => $bermissingreporttrans->transporter_name,
                    'ber_pallet' => $request->ber_pallet,
                    'missing_pallet' => $request->missing_pallet,
                    'reporter_prove' => $update->reporter_prove,
                    'note' => $request->note,
                ]);
            }
            elseif($transporter_id!=null){
                $approver = Auth::user()->name;
                // $bermissingapprovpool = PoolPallet::find($pool_pallet_id);
                $bermissingapprovtrans = Transporter::find($transporter_id);
                $alltransaction = Alltransaction::create([
                    'reference_ber_missing_id' => $update->ber_missing_pallet_id,
                    'receiver/approver' => $approver,
                    'status' => 'DISAPPROVED',
                    // 'pool_pallet' => $bermissingapprovpool->pool_name,
                    'reference_sjp_status_id' => $update->reference_sjp_status,
                    'transporter' => $bermissingreporttrans->transporter_name,
                    'ber_pallet' => $request->ber_pallet,
                    'missing_pallet' => $request->missing_pallet,
                    'reporter_prove' => $update->reporter_prove,
                    'note' => $request->note,
                ]);
            }


            // Membuat log transaksi report ber missing
            if($pool_pallet_id!=null){
                $approver = Auth::user()->name;
                $bermissingapprovpool = PoolPallet::find($pool_pallet_id);
                // $bermissingapprovtrans = Transporter::find($transporter_id);
                $bermissingapproved = Bermissingdisapproved::create([
                    'disapprover' => $approver,
                    'ber_missing_id' => $update->ber_missing_pallet_id,
                    'status' => 'DISAPPROVED',
                    'pool_pallet' => $bermissingapprovpool->pool_name,
                    // 'transporter' => $bermissingapprovtrans->transporter_name,
                    'reference_sjp_status' => $update->reference_sjp_status,
                    'ber_pallet' => $request->ber_pallet,
                    'missing_pallet' => $request->missing_pallet,
                    'reporter_prove' => $update->reporter_prove,
                    // 'berita_acara' => $request->berita_acara,
                    'note' => $request->note,
                ]);
            }

            elseif($transporter_id!=null){
                $approver = Auth::user()->name;
                // $bermissingapprovpool = PoolPallet::find($pool_pallet_id);
                $bermissingapprovtrans = Transporter::find($transporter_id);
                $bermissingapproved = Bermissingdisapproved::create([
                    'disapprover' => $approver,
                    'ber_missing_id' => $update->ber_missing_pallet_id,
                    'status' => 'DISAPPROVED',
                    // 'pool_pallet' => $bermissingapprovpool->pool_name,
                    'transporter' => $bermissingapprovtrans->transporter_name,
                    'reference_sjp_status' => $update->reference_sjp_status,
                    'ber_pallet' => $request->ber_pallet,
                    'missing_pallet' => $request->missing_pallet,
                    'reporter_prove' => $update->reporter_prove,
                    // 'berita_acara' => $request->berita_acara,
                    'note' => $request->note,
                ]);
            }

            if($pool_pallet_id!=null){
                $InventoryPool = PoolPallet::find($pool_pallet_id);
                $InventoryPool->ber_pallet = (($InventoryPool->ber_pallet)-($request->ber_pallet));
                $InventoryPool->missing_pallet = (($InventoryPool->missing_pallet)-($request->missing_pallet));
                $InventoryPool->good_pallet = (($InventoryPool->good_pallet)+(($request->ber_pallet)+($request->missing_pallet)));
                // $InventoryPool->missing_pallet = (($InventoryPool->good_pallet)+($request->missing_pallet));
                $InventoryPool->save();
            }

            elseif($transporter_id!=null){
                $InventoryTrans = Transporter::find($transporter_id);
                $InventoryTrans->ber_pallet = (($InventoryTrans->ber_pallet)-($request->ber_pallet));
                $InventoryTrans->missing_pallet = (($InventoryTrans->missing_pallet)-($request->missing_pallet));
                $InventoryTrans->good_pallet = (($InventoryTrans->good_pallet)+(($request->ber_pallet)+($request->missing_pallet)));
                // $InventoryTrans->missing_pallet = (($InventoryTrans->good_pallet)+($request->missing_pallet));
                $InventoryTrans->save();
            }

        DB::commit();
        return response()->json(['status' => 'success'], 200);

        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Approve BER/Missing Pallet Record'], 422);
        }
    }

    public function destroy($id)
    {
        $bermissing = Bermissing::find($id);
        $sjp_status = SjpStatus::find($bermissing->reference_sjp_status_id);
        $reporter_user = User::find($bermissing->reporter_user_id);
        $approver_user = User::find($bermissing->approver_user_id);
        $pool_pallet = PoolPallet::find($bermissing->pool_pallet_id);
        $transporter = Transporter::find($bermissing->transporter_id);
        DB::beginTransaction();
        try{

            if($sjp_status == null && $transporter == null){
                $deleted_item = DeletedItem::create([
                    'bmp_number' => $bermissing->bmp_number,
                    // 'sjps_number' => $sjp_status->sjps_number,
                    'pool_pallet' => $pool_pallet->pool_name,
                    // 'transporter' => $transporter->transporter_name,
                    'reporter/sender' => $reporter_user->name,
                    // 'receiver/approver' => $approver_user->name,
                    'ber_pallet' => $bermissing->ber_pallet,
                    'missing_pallet' => $bermissing->missing_pallet,
                    'created_by' => auth()->user()->name,
                    'note' => $bermissing->note,
                ]);
            }else{
                $deleted_item = DeletedItem::create([
                    'bmp_number' => $bermissing->bmp_number,
                    'sjps_number' => $sjp_status->sjps_number,
                    // 'pool_pallet' => $pool_pallet->pool_name,
                    'transporter' => $transporter->transporter_name,
                    'reporter/sender' => $reporter_user->name,
                    // 'receiver/approver' => $approver_user->name,
                    'ber_pallet' => $bermissing->ber_pallet,
                    'missing_pallet' => $bermissing->missing_pallet,
                    'created_by' => auth()->user()->name,
                    'note' => $bermissing->note,
                ]);
            }
            $bermissing->delete(); //KEMUDIAN HAPUS DATA TERSEBUT

        DB::commit();
        return response()->json(['status' => 'success'], 200);

        }catch (\Exception $e) {
            DB::rollback();
            return response()->json([
                'status' => 'error',
                'data' => $e->getMessage(),
                'message' => 'Error Delete BER/Missing Pallet Record'], 422);
        }
    }
}
