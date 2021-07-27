// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _VTOP_H_
#define _VTOP_H_  // guard

#include "verilated_heavy.h"

//==========

class VTop__Syms;

//----------

VL_MODULE(VTop) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(clock,0,0);
    VL_IN8(reset,0,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    CData/*0:0*/ Top__DOT__core__DOT___T_90;
    IData/*31:0*/ Top__DOT__core_io_dmem_addr;
    IData/*31:0*/ Top__DOT__core__DOT__regfile___05FT_11_data;
    IData/*31:0*/ Top__DOT__core__DOT__regfile___05FT_13_data;
    IData/*31:0*/ Top__DOT__core__DOT__pc_reg;
    IData/*31:0*/ Top__DOT__core__DOT__pc_plus1;
    IData/*31:0*/ Top__DOT__core__DOT__rs1_data;
    IData/*31:0*/ Top__DOT__core__DOT__rs2_data;
    IData/*31:0*/ Top__DOT__core__DOT___T_145;
    IData/*31:0*/ Top__DOT__core__DOT__imm_i_sext;
    IData/*31:0*/ Top__DOT__core__DOT__jump_reg_target;
    IData/*31:0*/ Top__DOT__core__DOT__jump_target;
    IData/*31:0*/ Top__DOT__core__DOT___T_102;
    IData/*31:0*/ Top__DOT__core__DOT__alu_out;
    IData/*31:0*/ Top__DOT__core__DOT___T_185;
    IData/*31:0*/ Top__DOT__memory__DOT__mem___05FT_1_data;
    IData/*31:0*/ Top__DOT__core__DOT__regfile[32];
    IData/*31:0*/ Top__DOT__memory__DOT__mem[256];
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    CData/*0:0*/ __Vclklast__TOP__clock;
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    VTop__Syms* __VlSymsp;  // Symbol table
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(VTop);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible with respect to DPI scope names.
    VTop(const char* name = "TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~VTop();
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval() { eval_step(); }
    /// Evaluate when calling multiple units/models per time step.
    void eval_step();
    /// Evaluate at end of a timestep for tracing, when using eval_step().
    /// Application must call after all eval() and before time changes.
    void eval_end_step() {}
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(VTop__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(VTop__Syms* symsp, bool first);
  private:
    static QData _change_request(VTop__Syms* __restrict vlSymsp);
    static QData _change_request_1(VTop__Syms* __restrict vlSymsp);
    void _ctor_var_reset() VL_ATTR_COLD;
  public:
    static void _eval(VTop__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif  // VL_DEBUG
  public:
    static void _eval_initial(VTop__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _eval_settle(VTop__Syms* __restrict vlSymsp) VL_ATTR_COLD;
    static void _sequent__TOP__1(VTop__Syms* __restrict vlSymsp);
    static void _settle__TOP__2(VTop__Syms* __restrict vlSymsp) VL_ATTR_COLD;
} VL_ATTR_ALIGNED(VL_CACHE_LINE_BYTES);

//----------


#endif  // guard
