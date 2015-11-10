####Creating bakers algorithm

defmodule Bakers do 
	def server do 
		receive do 
			{ sender, n} ->
				send sender, {:ok, serverCalc(n)}
				Bakers.server
			end
		end

		def serverCalc(0), do: 0
		def serverCalc(1), do: 1
		def serverCalc(n), do: serverCalc(n-1) + serverCalc(n-2)
	end


	defmodule Manager do 

		def run(first_host, second_host, third_host, num) do
			host = case :crypto.rand_uniform(0, 3) do
				0 -> first_host
				1 -> second_host
				2 -> third_host
			end
		#	listOfServ = [Node.spawn(first_host, Bakers, :server, []), Node.spawn(first_host, Bakers, :server, []), Node.spawn(second_host, Bakers, :server,  []), Node.spawn(second_host, Bakers, :server, [])]
		# 	listOfServ2 = [spawn(Bakers, :server, []), spawn(Bakers, :server, [])]
		cust1 = [5, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33]
		# 	# cust2 = [34, 33, 33, 33, 33, 33, 33, 33, 33, 34]
		# 	# { Node.spawn(first_host, manage(cust1, listOfServ))}
		# 	# { Node.spawn(second_host, manage(cust2, listOfServ))}
	#	listOfServ = Enum.into([Node.spawn(host, Bakers, :server, []), Node.spawn(host, Bakers, :server, [])], [Node.spawn(host, Bakers, :server, [])])
	listOfServ = makeNodes(first_host, second_host, third_host, num, [Node.spawn(host, Bakers, :server, [])])
	
end

def makeNodes(first_host, second_host, third_host, num, listOfNodes) do
	host = case :crypto.rand_uniform(0, 3) do
		0 -> first_host
		1 -> second_host
		2 -> third_host
	end
	IO.puts host
	if length(listOfNodes) < num do
		makeNodes(first_host, second_host, third_host, num, Enum.into(listOfNodes, [Node.spawn(host, Bakers, :server, [])]))
	else 
		cust1 = [5, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33, 33]
		manage(cust1, listOfNodes, first_host, second_host, third_host)
	end
end

def manage(cust, listOfPid, first_host, second_host, third_host) do
	host = case :crypto.rand_uniform(0, 3) do
		0 -> first_host
		1 -> second_host
		2 -> third_host
	end
	if length(cust) > 0 and length(listOfPid) > 0 do
		send List.first(listOfPid), {self, List.first(cust)}
		manage(List.delete_at(cust, 0), List.insert_at(listOfPid, 0, Node.spawn(host, Bakers, :server, [])), first_host, second_host, third_host)
				#manage(List.delete_at(cust, 0) listOfPid)
				#List.insert_at(listOfPid, 0, spawn(Bakers, :server, []))
				receive do 
					{:ok, answer} ->

						List.delete_at(listOfPid, 0)
						IO.puts "customer being served "
						IO.puts answer
						
					end
				end
			end


		end
