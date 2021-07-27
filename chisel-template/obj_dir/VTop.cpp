// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VTop.h for the primary calling header

#include "VTop.h"
#include "VTop__Syms.h"

//==========

void VTop::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate VTop::eval\n"); );
    VTop__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    VTop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
#ifdef VL_DEBUG
    // Debug assertions
    _eval_debug_assertions();
#endif  // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("Top.v", 385, "",
                "Verilated model didn't converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

void VTop::_eval_initial_loop(VTop__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
        _eval_settle(vlSymsp);
        _eval(vlSymsp);
        if (VL_UNLIKELY(++__VclockLoop > 100)) {
            // About to fail, so enable debug to see what's not settling.
            // Note you must run make with OPT=-DVL_DEBUG for debug prints.
            int __Vsaved_debug = Verilated::debug();
            Verilated::debug(1);
            __Vchange = _change_request(vlSymsp);
            Verilated::debug(__Vsaved_debug);
            VL_FATAL_MT("Top.v", 385, "",
                "Verilated model didn't DC converge\n"
                "- See DIDNOTCONVERGE in the Verilator manual");
        } else {
            __Vchange = _change_request(vlSymsp);
        }
    } while (VL_UNLIKELY(__Vchange));
}

VL_INLINE_OPT void VTop::_sequent__TOP__1(VTop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTop::_sequent__TOP__1\n"); );
    VTop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    CData/*7:0*/ __Vdlyvdim0__Top__DOT__memory__DOT__mem__v0;
    CData/*0:0*/ __Vdlyvset__Top__DOT__memory__DOT__mem__v0;
    IData/*31:0*/ __Vdlyvval__Top__DOT__memory__DOT__mem__v0;
    // Body
    __Vdlyvset__Top__DOT__memory__DOT__mem__v0 = 0U;
    if (VL_UNLIKELY((1U & (~ (IData)(vlTOPp->reset))))) {
        VL_FWRITEF(0x80000002U,"pc_reg : %10#\n",32,
                   vlTOPp->Top__DOT__core__DOT__pc_reg);
    }
    if (VL_UNLIKELY((1U & (~ (IData)(vlTOPp->reset))))) {
        VL_FWRITEF(0x80000002U,"inst : %x\n",32,vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data);
    }
    if (VL_UNLIKELY((1U & (~ (IData)(vlTOPp->reset))))) {
        VL_FWRITEF(0x80000002U,"rs1_addr : %2#\n",5,
                   (0x1fU & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                             >> 0xfU)));
    }
    if (VL_UNLIKELY((1U & (~ (IData)(vlTOPp->reset))))) {
        VL_FWRITEF(0x80000002U,"rs1_data : %10#\n",
                   32,vlTOPp->Top__DOT__core__DOT__rs1_data);
    }
    if (VL_UNLIKELY((1U & (~ (IData)(vlTOPp->reset))))) {
        VL_FWRITEF(0x80000002U,"rs2_addr : %2#\n",5,
                   (0x1fU & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                             >> 0x14U)));
    }
    if (VL_UNLIKELY((1U & (~ (IData)(vlTOPp->reset))))) {
        VL_FWRITEF(0x80000002U,"rs2_data : %10#\n",
                   32,vlTOPp->Top__DOT__core__DOT__rs2_data);
    }
    if (VL_UNLIKELY((1U & (~ (IData)(vlTOPp->reset))))) {
        VL_FWRITEF(0x80000002U,"wb_addr : %2#\n",5,
                   (0x1fU & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                             >> 7U)));
    }
    if (VL_UNLIKELY((1U & (~ (IData)(vlTOPp->reset))))) {
        VL_FWRITEF(0x80000002U,"wb_data : %10#\n",32,
                   ((0x2003U == (0x707fU & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                     ? vlTOPp->Top__DOT__memory__DOT__mem
                    [(0xffU & vlTOPp->Top__DOT__core_io_dmem_addr)]
                     : vlTOPp->Top__DOT__core__DOT___T_185));
    }
    if (VL_UNLIKELY((1U & (~ (IData)(vlTOPp->reset))))) {
        VL_FWRITEF(0x80000002U,"wb_data : %x\n",32,
                   ((0x2003U == (0x707fU & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                     ? vlTOPp->Top__DOT__memory__DOT__mem
                    [(0xffU & vlTOPp->Top__DOT__core_io_dmem_addr)]
                     : vlTOPp->Top__DOT__core__DOT___T_185));
    }
    if (VL_UNLIKELY((1U & (~ (IData)(vlTOPp->reset))))) {
        VL_FWRITEF(0x80000002U,"---------\n");
    }
    if ((0x2023U == (0x707fU & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))) {
        __Vdlyvval__Top__DOT__memory__DOT__mem__v0 
            = ((0U != (0x1fU & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                                >> 0x14U))) ? vlTOPp->Top__DOT__core__DOT__regfile___05FT_13_data
                : 0U);
        __Vdlyvset__Top__DOT__memory__DOT__mem__v0 = 1U;
        __Vdlyvdim0__Top__DOT__memory__DOT__mem__v0 
            = (0xffU & vlTOPp->Top__DOT__core_io_dmem_addr);
    }
    if (__Vdlyvset__Top__DOT__memory__DOT__mem__v0) {
        vlTOPp->Top__DOT__memory__DOT__mem[__Vdlyvdim0__Top__DOT__memory__DOT__mem__v0] 
            = __Vdlyvval__Top__DOT__memory__DOT__mem__v0;
    }
    vlTOPp->Top__DOT__core__DOT__pc_reg = ((IData)(vlTOPp->reset)
                                            ? 0U : 
                                           ((0x6fU 
                                             == (0x7fU 
                                                 & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                             ? vlTOPp->Top__DOT__core__DOT__jump_target
                                             : ((0x67U 
                                                 == 
                                                 (0x707fU 
                                                  & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                 ? vlTOPp->Top__DOT__core__DOT__jump_reg_target
                                                 : vlTOPp->Top__DOT__core__DOT__pc_plus1)));
    vlTOPp->Top__DOT__core__DOT__pc_plus1 = ((IData)(1U) 
                                             + vlTOPp->Top__DOT__core__DOT__pc_reg);
    vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
        = vlTOPp->Top__DOT__memory__DOT__mem[(0xffU 
                                              & vlTOPp->Top__DOT__core__DOT__pc_reg)];
    vlTOPp->Top__DOT__core__DOT__jump_target = (vlTOPp->Top__DOT__core__DOT__pc_reg 
                                                + (
                                                   (((0x80000000U 
                                                      & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data)
                                                      ? 0x7ffU
                                                      : 0U) 
                                                    << 0x15U) 
                                                   | ((0x100000U 
                                                       & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                                                          >> 0xbU)) 
                                                      | ((0xff000U 
                                                          & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data) 
                                                         | ((0x800U 
                                                             & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                                                                >> 9U)) 
                                                            | (0x7feU 
                                                               & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                                                                  >> 0x14U)))))));
    vlTOPp->Top__DOT__core__DOT__regfile___05FT_13_data 
        = vlTOPp->Top__DOT__core__DOT__regfile[(0x1fU 
                                                & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                                                   >> 0x14U))];
    vlTOPp->Top__DOT__core__DOT__imm_i_sext = ((((0x80000000U 
                                                  & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data)
                                                  ? 0xfffffU
                                                  : 0U) 
                                                << 0xcU) 
                                               | (0xfffU 
                                                  & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                                                     >> 0x14U)));
    vlTOPp->Top__DOT__core__DOT__regfile___05FT_11_data 
        = vlTOPp->Top__DOT__core__DOT__regfile[(0x1fU 
                                                & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                                                   >> 0xfU))];
    vlTOPp->Top__DOT__core__DOT__rs2_data = ((0U != 
                                              (0x1fU 
                                               & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                                                  >> 0x14U)))
                                              ? vlTOPp->Top__DOT__core__DOT__regfile___05FT_13_data
                                              : 0U);
    if ((0U != (0x1fU & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                         >> 0xfU)))) {
        vlTOPp->Top__DOT__core__DOT___T_145 = vlTOPp->Top__DOT__core__DOT__regfile___05FT_11_data;
        vlTOPp->Top__DOT__core__DOT__rs1_data = vlTOPp->Top__DOT__core__DOT__regfile___05FT_11_data;
    } else {
        vlTOPp->Top__DOT__core__DOT___T_145 = 0U;
        vlTOPp->Top__DOT__core__DOT__rs1_data = 0U;
    }
    vlTOPp->Top__DOT__core_io_dmem_addr = ((0x2023U 
                                            == (0x707fU 
                                                & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                            ? (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                               + ((
                                                   ((0x80000000U 
                                                     & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data)
                                                     ? 0xfffffU
                                                     : 0U) 
                                                   << 0xcU) 
                                                  | ((0xfe0U 
                                                      & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                                                         >> 0x14U)) 
                                                     | (0x1fU 
                                                        & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                                                           >> 7U)))))
                                            : vlTOPp->Top__DOT__core__DOT__imm_i_sext);
    vlTOPp->Top__DOT__core__DOT__jump_reg_target = 
        (vlTOPp->Top__DOT__core__DOT__rs1_data + vlTOPp->Top__DOT__core__DOT__imm_i_sext);
    vlTOPp->Top__DOT__core__DOT___T_90 = (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                          < vlTOPp->Top__DOT__core__DOT__imm_i_sext);
    vlTOPp->Top__DOT__core__DOT___T_102 = ((0x5033U 
                                            == (0xfe00707fU 
                                                & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                            ? (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                               >> (0x1fU 
                                                   & vlTOPp->Top__DOT__core__DOT__rs2_data))
                                            : ((0x40005033U 
                                                == 
                                                (0xfe00707fU 
                                                 & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                ? VL_SHIFTRS_III(32,32,5, vlTOPp->Top__DOT__core__DOT___T_145, 
                                                                 (0x1fU 
                                                                  & vlTOPp->Top__DOT__core__DOT__rs2_data))
                                                : (
                                                   (0x1013U 
                                                    == 
                                                    (0xfc00707fU 
                                                     & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                    ? (IData)(
                                                              (0x7fffffffffffffffULL 
                                                               & ((QData)((IData)(vlTOPp->Top__DOT__core__DOT__rs1_data)) 
                                                                  << 
                                                                  (0x1fU 
                                                                   & vlTOPp->Top__DOT__core__DOT__imm_i_sext))))
                                                    : 
                                                   ((0x5013U 
                                                     == 
                                                     (0xfc00707fU 
                                                      & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                     ? 
                                                    (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                                     >> 
                                                     (0x1fU 
                                                      & vlTOPp->Top__DOT__core__DOT__imm_i_sext))
                                                     : 
                                                    ((0x40005013U 
                                                      == 
                                                      (0xfc00707fU 
                                                       & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                      ? 
                                                     VL_SHIFTRS_III(32,32,5, vlTOPp->Top__DOT__core__DOT___T_145, 
                                                                    (0x1fU 
                                                                     & vlTOPp->Top__DOT__core__DOT__imm_i_sext))
                                                      : 
                                                     ((0x2033U 
                                                       == 
                                                       (0xfe00707fU 
                                                        & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                       ? 
                                                      VL_LTS_III(1,32,32, vlTOPp->Top__DOT__core__DOT___T_145, 
                                                                 ((0U 
                                                                   != 
                                                                   (0x1fU 
                                                                    & (vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data 
                                                                       >> 0x14U)))
                                                                   ? vlTOPp->Top__DOT__core__DOT__regfile___05FT_13_data
                                                                   : 0U))
                                                       : 
                                                      ((0x3033U 
                                                        == 
                                                        (0xfe00707fU 
                                                         & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                        ? 
                                                       (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                                        < vlTOPp->Top__DOT__core__DOT__rs2_data)
                                                        : 
                                                       ((0x2013U 
                                                         == 
                                                         (0x707fU 
                                                          & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                         ? (IData)(vlTOPp->Top__DOT__core__DOT___T_90)
                                                         : 
                                                        ((0x3013U 
                                                          == 
                                                          (0x707fU 
                                                           & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data)) 
                                                         & (IData)(vlTOPp->Top__DOT__core__DOT___T_90))))))))));
    vlTOPp->Top__DOT__core__DOT__alu_out = ((0x33U 
                                             == (0xfe00707fU 
                                                 & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                             ? (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                                + vlTOPp->Top__DOT__core__DOT__rs2_data)
                                             : (((0x13U 
                                                  == 
                                                  (0x707fU 
                                                   & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data)) 
                                                 | (0x2003U 
                                                    == 
                                                    (0x707fU 
                                                     & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data)))
                                                 ? vlTOPp->Top__DOT__core__DOT__jump_reg_target
                                                 : 
                                                ((0x40000033U 
                                                  == 
                                                  (0xfe00707fU 
                                                   & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                  ? 
                                                 (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                                  - vlTOPp->Top__DOT__core__DOT__rs2_data)
                                                  : 
                                                 ((0x7033U 
                                                   == 
                                                   (0xfe00707fU 
                                                    & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                   ? 
                                                  (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                                   & vlTOPp->Top__DOT__core__DOT__rs2_data)
                                                   : 
                                                  ((0x6033U 
                                                    == 
                                                    (0xfe00707fU 
                                                     & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                    ? 
                                                   (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                                    | vlTOPp->Top__DOT__core__DOT__rs2_data)
                                                    : 
                                                   ((0x4033U 
                                                     == 
                                                     (0xfe00707fU 
                                                      & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                     ? 
                                                    (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                                     ^ vlTOPp->Top__DOT__core__DOT__rs2_data)
                                                     : 
                                                    ((0x7013U 
                                                      == 
                                                      (0x707fU 
                                                       & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                      ? 
                                                     (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                                      & vlTOPp->Top__DOT__core__DOT__imm_i_sext)
                                                      : 
                                                     ((0x6013U 
                                                       == 
                                                       (0x707fU 
                                                        & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                       ? 
                                                      (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                                       | vlTOPp->Top__DOT__core__DOT__imm_i_sext)
                                                       : 
                                                      ((0x4013U 
                                                        == 
                                                        (0x707fU 
                                                         & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                        ? 
                                                       (vlTOPp->Top__DOT__core__DOT__rs1_data 
                                                        ^ vlTOPp->Top__DOT__core__DOT__imm_i_sext)
                                                        : 
                                                       ((0x1033U 
                                                         == 
                                                         (0xfe00707fU 
                                                          & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                                         ? (IData)(
                                                                   (0x7fffffffffffffffULL 
                                                                    & ((QData)((IData)(vlTOPp->Top__DOT__core__DOT__rs1_data)) 
                                                                       << 
                                                                       (0x1fU 
                                                                        & vlTOPp->Top__DOT__core__DOT__rs2_data))))
                                                         : vlTOPp->Top__DOT__core__DOT___T_102))))))))));
    vlTOPp->Top__DOT__core__DOT___T_185 = ((0x67U == 
                                            (0x707fU 
                                             & vlTOPp->Top__DOT__memory__DOT__mem___05FT_1_data))
                                            ? ((IData)(1U) 
                                               + vlTOPp->Top__DOT__core__DOT__pc_reg)
                                            : vlTOPp->Top__DOT__core__DOT__alu_out);
}

void VTop::_eval(VTop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTop::_eval\n"); );
    VTop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if (((IData)(vlTOPp->clock) & (~ (IData)(vlTOPp->__Vclklast__TOP__clock)))) {
        vlTOPp->_sequent__TOP__1(vlSymsp);
    }
    // Final
    vlTOPp->__Vclklast__TOP__clock = vlTOPp->clock;
}

VL_INLINE_OPT QData VTop::_change_request(VTop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTop::_change_request\n"); );
    VTop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    return (vlTOPp->_change_request_1(vlSymsp));
}

VL_INLINE_OPT QData VTop::_change_request_1(VTop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTop::_change_request_1\n"); );
    VTop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void VTop::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTop::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((clock & 0xfeU))) {
        Verilated::overWidthError("clock");}
    if (VL_UNLIKELY((reset & 0xfeU))) {
        Verilated::overWidthError("reset");}
}
#endif  // VL_DEBUG
