import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles


@cocotb.test()
async def test_8bitcounter_AI(dut):
    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # reset
    dut._log.info("check reset")
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 1)
    await ClockCycles(dut.clk, 10)
    assert dut.uo_out.value == 0

    dut._log.info("check ena disable." + str(dut.uo_out.value))
    dut.ena.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 1)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 10)
    assert dut.uo_out.value == 0

    dut._log.info("check ena enable.")
    dut.ena.value = 1
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)

    await ClockCycles(dut.clk, 20)
    dut._log.info("check uo_out=" + str(dut.uo_out.value))
    assert dut.uo_out.value == 20
    await ClockCycles(dut.clk, 10)
    dut._log.info("check uo_out=" + str(dut.uo_out.value))
    assert dut.uo_out.value == 30

    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 1)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 1)
    for i in range(255):
        await ClockCycles(dut.clk, 1)
        dut._log.info("check uo_out=" + str(dut.uo_out.value) + ", i=" + str(i))
        assert dut.uo_out.value == i+1

