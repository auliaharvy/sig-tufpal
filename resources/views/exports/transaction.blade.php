<table>
    <thead>
        <tr>
            <th colspan="2"><strong>SJP Pallet {{ $month }} - {{ $year }}</strong></th>
        </tr>
        <tr>
            <th colspan="2"></th>
        </tr>
        <tr>
            <th>Month</th>
            <th>Total Pallet</th>
        </tr>
    </thead>
    <tbody>
        @foreach($transaction as $row)
            <tr>
                <td>{{ $row['date'] }}</td>
                <td>{{ number_format($row['total']) }} Pallet</td>
            </tr>
        @endforeach
    </tbody>
</table>