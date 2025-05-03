//1) 
program final2;
const
	dimF = 500;
type
	cliente = record
		numC:integer;
		dni:integer;
		monto:real;
	end;
	vector = array [1..dimF] of cliente;//vector que se dispone
	vecDni = array [1..9] of integer;//vector para guardar dni 
	
procedure leerCliente (var c:cliente);//SE DISPONE
procedure cargarVector (var v:vector; var dimL:integer);//SE DISPONE

procedure cargarVecDni(var vDni:vecDni; dig:integer; var dimL:integer);
begin
	vDni[dimL]:= dig;
	dimL:= dimL + 1;
end;

function capicua(vDni:vecDni; dimL:integer):boolean;
var
	mitad:integer;
	pos:integer;
	ok:boolean;
begin
	ok:= true;
	pos:= 1;
	mitad:= dimL/2;
	while (pos <= mitad) and (ok = true) do begin
		if (vDni[pos] <> vDni[dimL]) then
			ok:=false;
		pos:= pos + 1;
		dimL:= dimL - 1;
	end;
	capicua:= ok;
end;

procedure recorrerVector(v:vector; dimL:integer; var cumple:integer);
var
	vDni:vecDni;
	i,num,dig:integer;
	dimLDni:integer;//dimL del vector dni
begin
	for i:= 1 to dimL do begin 
		num:= v[i].dni;
		dimLDni:=1;
		while (num <> 0) do begin
			dig:= num MOD 10;//ultimo digito
			cargarVecDni(vDni,dig,dimLDni);
			num:= num DIV 10;//achico numero
		end;
		if (capicua(vDni,dimLDni)) then 
			cumple:= cumple + 1;
	end;
end;

{PROGRAMA PRINCIPAL}
var
	v:vector;
	dimL:integer;
	cumple:integer;//cant dni que son capicua
begin
	dimL:= 0;
	cumple:= 0;
	cargarVector(v,dimL);
	recorrerVector(v,dimL,cumple);
	writeln ('La cantidad de DNI capicua es: ',cumple);
End.

{2) Todas son correctas.

3) Estatica: 348 bytes
	const = 6 bytes
	v = 16*4= 64 bytes
	i,j = 6+6= 12 bytes
	e = 256 + 6 + 4= 266
	
Dinamica: 1330 bytes
	new = 11*266= 2926
	dispose = 6*266= 1596

4) Tiempo de Ejecución:
}
