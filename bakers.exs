####Creating bakers algorithm

defmodule Bakers do 
	def server do 
		receive do 
			{ sender, n} ->
				send sender, {:ok, serverCalc(n)}
			end
		end

		def serverCalc(0), do: 0
		def serverCalc(1), do: 1
		def serverCalc(n), do: serverCalc(n-1) + serverCalc(n-2)
	end


	defmodule Manager do 


		def run(cust, listOfPid) do
			if length(cust) > 0  do
				send List.first(listOfPid), {self, List.first(cust)}
				receive do 
					{:ok, answer} ->
						List.insert_at(listOfPid, 0, spawn(Bakers, :server, []))
						IO.puts answer
					end

					run(List.delete_at(cust, 0), List.delete_at(listOfPid, 0))
				end
			end
		end

		listOfServ = [spawn(Bakers, :server, []), spawn(Bakers, :server, [])]

		Manager.run([10, 9, 8 ], listOfServ)
