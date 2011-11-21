## This file was generated by taghandlerwriter.pl script.
##
## Copyright 2011 Krzesimir Nowak
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
##

package Gir::Api::Class;

use strict;
use warnings;

use parent qw(Gir::Api::Common::Base);

use Gir::Api::Attribute;
use Gir::Api::Constructor;
use Gir::Api::Doc;
use Gir::Api::Field;
use Gir::Api::Function;
use Gir::Api::GlibSignal;
use Gir::Api::Implements;
use Gir::Api::Method;
use Gir::Api::Property;
use Gir::Api::Record;
use Gir::Api::Union;
use Gir::Api::VirtualMethod;

sub new ($)
{
  my $type = shift;
  my $class = (ref ($type) or $type or 'Gir::Api::Class');
  my $groups =
  [
    'group_attribute',
    'group_constructor',
    'group_doc',
    'group_field',
    'group_function',
    'group_glib_signal',
    'group_implements',
    'group_method',
    'group_property',
    'group_record',
    'group_union',
    'group_virtual_method'
  ];
  my $attributes =
  [
    'attribute_abstract',
    'attribute_c_symbol_prefix',
    'attribute_c_type',
    'attribute_deprecated',
    'attribute_deprecated_version',
    'attribute_glib_fundamental',
    'attribute_glib_get_type',
    'attribute_glib_get_value_func',
    'attribute_glib_ref_func',
    'attribute_glib_set_value_func',
    'attribute_glib_type_name',
    'attribute_glib_type_struct',
    'attribute_glib_unref_func',
    'attribute_introspectable',
    'attribute_name',
    'attribute_parent',
    'attribute_version'
  ];
  my $self = $class->SUPER::new ($groups, $attributes);

  bless ($self, $class);
  return $self;
}

sub new_with_params ($$)
{
  my ($type, $params) = @_;
  my $self = Gir::Api::Class::new ($type);

  $self->set_a_abstract($params->{'abstract'});
  $self->set_a_c_symbol_prefix($params->{'c:symbol-prefix'});
  $self->set_a_c_type($params->{'c:type'});
  $self->set_a_deprecated($params->{'deprecated'});
  $self->set_a_deprecated_version($params->{'deprecated-version'});
  $self->set_a_glib_fundamental($params->{'glib:fundamental'});
  $self->set_a_glib_get_type($params->{'glib:get-type'});
  $self->set_a_glib_get_value_func($params->{'glib:get-value-func'});
  $self->set_a_glib_ref_func($params->{'glib:ref-func'});
  $self->set_a_glib_set_value_func($params->{'glib:set-value-func'});
  $self->set_a_glib_type_name($params->{'glib:type-name'});
  $self->set_a_glib_type_struct($params->{'glib:type-struct'});
  $self->set_a_glib_unref_func($params->{'glib:unref-func'});
  $self->set_a_introspectable($params->{'introspectable'});
  $self->set_a_name($params->{'name'});
  $self->set_a_parent($params->{'parent'});
  $self->set_a_version($params->{'version'});

  return $self;
}

sub get_g_attribute_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_attribute', $name);
}

sub get_g_constructor_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_constructor', $name);
}

sub get_g_doc_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_doc', $name);
}

sub get_g_field_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_field', $name);
}

sub get_g_function_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_function', $name);
}

sub get_g_glib_signal_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_glib_signal', $name);
}

sub get_g_implements_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_implements', $name);
}

sub get_g_method_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_method', $name);
}

sub get_g_property_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_property', $name);
}

sub get_g_record_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_record', $name);
}

sub get_g_union_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_union', $name);
}

sub get_g_virtual_method_by_name ($$)
{
  my ($self, $name) = @_;

  return $self->_get_group_member_by_name ('group_virtual_method', $name);
}


sub get_g_attribute_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_attribute', $index);
}

sub get_g_constructor_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_constructor', $index);
}

sub get_g_doc_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_doc', $index);
}

sub get_g_field_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_field', $index);
}

sub get_g_function_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_function', $index);
}

sub get_g_glib_signal_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_glib_signal', $index);
}

sub get_g_implements_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_implements', $index);
}

sub get_g_method_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_method', $index);
}

sub get_g_property_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_property', $index);
}

sub get_g_record_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_record', $index);
}

sub get_g_union_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_union', $index);
}

sub get_g_virtual_method_by_index ($$)
{
  my ($self, $index) = @_;

  return $self->_get_group_member_by_index ('group_virtual_method', $index);
}


sub get_g_attribute_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_attribute');
}

sub get_g_constructor_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_constructor');
}

sub get_g_doc_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_doc');
}

sub get_g_field_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_field');
}

sub get_g_function_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_function');
}

sub get_g_glib_signal_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_glib_signal');
}

sub get_g_implements_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_implements');
}

sub get_g_method_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_method');
}

sub get_g_property_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_property');
}

sub get_g_record_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_record');
}

sub get_g_union_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_union');
}

sub get_g_virtual_method_count ($)
{
  my $self = shift;

  return $self->_get_group_member_count ('group_virtual_method');
}


sub add_g_attribute ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_attribute', $member_name, $member);
}

sub add_g_constructor ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_constructor', $member_name, $member);
}

sub add_g_doc ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_doc', $member_name, $member);
}

sub add_g_field ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_field', $member_name, $member);
}

sub add_g_function ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_function', $member_name, $member);
}

sub add_g_glib_signal ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_glib_signal', $member_name, $member);
}

sub add_g_implements ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_implements', $member_name, $member);
}

sub add_g_method ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_method', $member_name, $member);
}

sub add_g_property ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_property', $member_name, $member);
}

sub add_g_record ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_record', $member_name, $member);
}

sub add_g_union ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_union', $member_name, $member);
}

sub add_g_virtual_method ($$$)
{
  my ($self, $member_name, $member) = @_;

  $self->_add_member_to_group ('group_virtual_method', $member_name, $member);
}


sub get_a_abstract ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_abstract');
}

sub get_a_c_symbol_prefix ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_c_symbol_prefix');
}

sub get_a_c_type ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_c_type');
}

sub get_a_deprecated ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_deprecated');
}

sub get_a_deprecated_version ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_deprecated_version');
}

sub get_a_glib_fundamental ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_glib_fundamental');
}

sub get_a_glib_get_type ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_glib_get_type');
}

sub get_a_glib_get_value_func ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_glib_get_value_func');
}

sub get_a_glib_ref_func ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_glib_ref_func');
}

sub get_a_glib_set_value_func ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_glib_set_value_func');
}

sub get_a_glib_type_name ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_glib_type_name');
}

sub get_a_glib_type_struct ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_glib_type_struct');
}

sub get_a_glib_unref_func ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_glib_unref_func');
}

sub get_a_introspectable ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_introspectable');
}

sub get_a_name ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_name');
}

sub get_a_parent ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_parent');
}

sub get_a_version ($)
{
  my ($self) = @_;

  return $self->_get_attribute ('attribute_version');
}


sub set_a_abstract ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_abstract', $value);
}

sub set_a_c_symbol_prefix ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_c_symbol_prefix', $value);
}

sub set_a_c_type ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_c_type', $value);
}

sub set_a_deprecated ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_deprecated', $value);
}

sub set_a_deprecated_version ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_deprecated_version', $value);
}

sub set_a_glib_fundamental ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_glib_fundamental', $value);
}

sub set_a_glib_get_type ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_glib_get_type', $value);
}

sub set_a_glib_get_value_func ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_glib_get_value_func', $value);
}

sub set_a_glib_ref_func ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_glib_ref_func', $value);
}

sub set_a_glib_set_value_func ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_glib_set_value_func', $value);
}

sub set_a_glib_type_name ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_glib_type_name', $value);
}

sub set_a_glib_type_struct ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_glib_type_struct', $value);
}

sub set_a_glib_unref_func ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_glib_unref_func', $value);
}

sub set_a_introspectable ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_introspectable', $value);
}

sub set_a_name ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_name', $value);
}

sub set_a_parent ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_parent', $value);
}

sub set_a_version ($$)
{
  my ($self, $value) = @_;

  $self->_set_attribute ('attribute_version', $value);
}


1; # indicate proper module load.