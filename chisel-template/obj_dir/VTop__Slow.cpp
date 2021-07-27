// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See VTop.h for the primary calling header

#include "VTop.h"
#include "VTop__Syms.h"

//==========

VL_CTOR_IMP(VTop) {
    VTop__Syms* __restrict vlSymsp = __VlSymsp = new VTop__Syms(this, name());
    VTop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void VTop::__Vconfigure(VTop__Syms* vlSymsp, bool first) {
    if (false && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
    if (false && this->__VlSymsp) {}  // Prevent unused
    Verilated::timeunit(-12);
    Verilated::timeprecision(-12);
}

VTop::~VTop() {
    VL_DO_CLEAR(delete __VlSymsp, __VlSymsp = nullptr);
}

void VTop::_settle__TOP__2(VTop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTop::_settle__TOP__2\n"); );
    VTop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
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

void VTop::_eval_initial(VTop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTop::_eval_initial\n"); );
    VTop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->__Vclklast__TOP__clock = vlTOPp->clock;
}

void VTop::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTop::final\n"); );
    // Variables
    VTop__Syms* __restrict vlSymsp = this->__VlSymsp;
    VTop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void VTop::_eval_settle(VTop__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTop::_eval_settle\n"); );
    VTop* const __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_settle__TOP__2(vlSymsp);
}

void VTop::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    VTop::_ctor_var_reset\n"); );
    // Body
    clock = VL_RAND_RESET_I(1);
    reset = VL_RAND_RESET_I(1);
    Top__DOT__core_io_dmem_addr = VL_RAND_RESET_I(32);
    for (int __Vi0=0; __Vi0<32; ++__Vi0) {
        Top__DOT__core__DOT__regfile[__Vi0] = VL_RAND_RESET_I(32);
    }
    Top__DOT__core__DOT__regfile___05FT_11_data = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT__regfile___05FT_13_data = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT__pc_reg = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT__pc_plus1 = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT__rs1_data = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT__rs2_data = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT___T_145 = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT__imm_i_sext = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT__jump_reg_target = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT__jump_target = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT___T_90 = VL_RAND_RESET_I(1);
    Top__DOT__core__DOT___T_102 = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT__alu_out = VL_RAND_RESET_I(32);
    Top__DOT__core__DOT___T_185 = VL_RAND_RESET_I(32);
    for (int __Vi0=0; __Vi0<256; ++__Vi0) {
        Top__DOT__memory__DOT__mem[__Vi0] = VL_RAND_RESET_I(32);
    }
    Top__DOT__memory__DOT__mem___05FT_1_data = VL_RAND_RESET_I(32);
}
