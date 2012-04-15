# -*- mode: perl; perl-indent-level: 2; indent-tabs-mode: nil -*-
# gmmproc - Common::Output::Shared module
#
# Copyright 2011 glibmm development team
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307, USA.
#

package Common::Output::Shared;

use strict;
use warnings;
use feature ':5.10';

use constant
{
  'FLAGS_TYPE' => 'Flags',
  'ENUM_TYPE' => 'Enum',
};

use Common::Variables;
use Common::Sections;

sub nl
{
  return join '', @_, "\n";
}

sub doxy_skip_begin ()
{
  return '#ifndef DOXYGEN_SHOULD_SKIP_THIS';
}

sub doxy_skip_end ()
{
  return '#endif // DOXYGEN_SHOULD_SKIP_THIS';
}

sub open_namespaces ($)
{
  my ($wrap_parser) = @_;
  my $namespaces = $wrap_parser->get_namespaces;
  my $code_string = '';

  foreach my $opened_name (@{$namespaces})
  {
    $code_string .= nl ('namespace ' . $opened_name) .
                    nl ('{') .
                    nl ();
  }
  return $code_string;
}

sub close_namespaces ($)
{
  my ($wrap_parser) = @_;
  my $namespaces = $wrap_parser->get_namespaces;
  my $code_string = '';

  foreach my $closed_name (reverse @{$namespaces})
  {
    $code_string .= nl ('} // namespace ' . $closed_name) .
                    nl ();
  }
  return $code_string;
}

sub get_first_class ($)
{
  my ($wrap_parser) = @_;
  my $classes = $wrap_parser->get_classes;

  if (@{$classes})
  {
    return $classes->[0];
  }
  die;
}

sub get_first_namespace ($)
{
  my ($wrap_parser) = @_;
  my $namespaces = $wrap_parser->get_namespaces;

  if (@{$namespaces})
  {
    return $namespaces->[0];
  }
  die;
}

# returns VteTerminal
sub get_c_type ($)
{
  my ($wrap_parser) = @_;

  return $wrap_parser->get_c_class;
}

# returns Terminal
sub get_cpp_type ($)
{
  my ($wrap_parser) = @_;
  my $classes = $wrap_parser->get_classes;

  if (@{$classes})
  {
    return $classes->[-1];
  }
  return undef;
}

# returns Terminal, the difference is that it can also return Foo::Bar if Bar is
# a class inside a Foo class
sub get_full_cpp_type ($)
{
  my ($wrap_parser) = @_;
  my $classes = $wrap_parser->get_classes;
  my $full_cpp_class = join '::', @{$classes};

  return $full_cpp_class;
}

# returns Gnome::Vte
sub get_full_namespace ($)
{
  my ($wrap_parser) = @_;
  my $namespaces = $wrap_parser->get_namespaces;
  my $full_namespace = join '::', @{$namespaces};

  return $full_namespace;
}

# returns Gnome::Vte::Terminal
sub get_complete_cpp_type ($)
{
  my ($wrap_parser) = @_;
  my $namespaces = get_full_namespace $wrap_parser;
  my $classes = get_full_cpp_type $wrap_parser;

  return join '::', $namespaces, $classes;
}

# returns Terminal_Class for Gnome::Vte::Terminal.
# returns Terminal_Foo_Class for Gnome::Vte::Terminal::Foo.
sub get_cpp_class_type ($)
{
  my ($wrap_parser) = @_;
  my $full_cpp_type = get_full_cpp_type $wrap_parser;

  $full_cpp_type =~ s/::/_/g;
  return $full_cpp_type . '_Class';
}

# returns Gnome::Vte::Terminal_Class for Gnome::Vte::Terminal.
# returns Gnome::Vte::Terminal_Foo_Class for Gnome::Vte::Terminal::Foo.
sub get_complete_cpp_class_type ($)
{
  my ($wrap_parser) = @_;
  my $full_namespace = get_full_namespace $wrap_parser;
  my $cpp_class_type = get_cpp_class_type $wrap_parser;

  return join '::', $full_namespace, $cpp_class_type;
}

# TODO: implement beautifying if I am really bored.
sub convert_members_to_strings ($)
{
  my ($members) = @_;
  my @strings = ();

  foreach my $pair (@{$members})
  {
    my $name = $pair->[0];
    my $value = $pair->[1];

    push @strings, '    ' . $name . ' = ' . $value;
  }
  return \@strings;
}

sub get_section ($$);
sub get_variable ($$);

sub output_enum_gtype_func_h ($$$$)
{
  my ($wrap_parser, $cpp_type, $type, $get_type_func) = @_;

  if (defined $get_type_func)
  {
    my $namespaces = $wrap_parser->get_namespaces;
    my $main_section = $wrap_parser->get_main_section;
    my $classes = $wrap_parser->get_classes;
    my $full_cpp_type = join '::', (get_full_cpp_type $wrap_parser), $cpp_type;
    my $close = 1;
    my $value_base = 'Glib::Value_' . $type;
    my $code_string = '';
    my $section_manager = $wrap_parser->get_section_manager;

    if (@{$namespaces} == 1 and $namespaces->[0] eq 'Glib')
    {
      $close = 0;
    }

    if ($close)
    {
      $code_string .= close_namespaces ($wrap_parser) .
                      nl (doxy_skip_begin) .
                      nl ('namespace Glib') .
                      nl ('{') .
                      nl ();
    }
    else
    {
      $code_string .= nl (doxy_skip_begin);
    }

    $code_string .= nl ('template <>') .
                    nl ('class Value< ' . $full_cpp_type . ' > : public ' . $value_base . '< ' . $full_cpp_type . ' >') .
                    nl ('{') .
                    nl ('public:') .
                    nl ('  static GType value_type() G_GNUC_CONST;') .
                    nl ('};') .
                    nl ();

    if ($close)
    {
      $code_string .= nl ('} // namespace Glib') .
                      nl (doxy_skip_end) .
                      nl () .
                      open_namespaces ($wrap_parser);
    }
    else
    {
      $code_string .= nl (doxy_skip_end) .
                      nl ();
    }

    if (@{$classes} > 0)
    {
      my $section = get_section $wrap_parser, Common::Sections::H_AFTER_FIRST_CLASS;

      $section_manager->append_string_to_section ($code_string, $section);
    }
    else
    {
      $section_manager->append_string_to_section ($code_string, $main_section);
    }
  }
}

sub output_enum_gtype_func_cc ($$$)
{
  my ($wrap_parser, $cpp_type, $get_type_func) = @_;

  if (defined $get_type_func)
  {
    my $container_cpp_type = get_full_cpp_type $wrap_parser;
    my $full_cpp_type = join '::', $container_cpp_type, $cpp_type;
    my $section_manager = $wrap_parser->get_section_manager;
    my $code_string = nl ('namespace Glib') .
                      nl ('{') .
                      nl () .
                      nl ('// static') .
                      nl ('GType Glib::Value< ' . $full_cpp_type . ' >::value_type()') .
                      nl ('{') .
                      nl ('  return ' . $get_type_func . '();') .
                      nl ('}') .
                      nl () .
                      nl ('} // namespace Glib') .
                      nl ();
    my $section = get_section $wrap_parser, Common::Sections::CC_END;

    $section_manager->append_string_to_section ($code_string, $section);
  }
}

sub generate_conditional ($)
{
  my ($wrap_parser) = @_;
  my $number = $wrap_parser->get_number;

  return 'CONDITIONAL#' . $number;
}

sub struct_prototype ($$$)
{
  my ($wrap_parser, $c_name, $c_class_name) = @_;
  my $section_manager = $wrap_parser->get_section_manager;
  my $code_string = nl (doxy_skip_begin) .
                    nl ('typedef struct _' . $c_name . ' ' . $c_name . ';') .
                    nl ('typedef struct _' . $c_class_name . ' ' . $c_class_name . ';') .
                    nl (doxy_skip_end) .
                    nl ();
  my $variable = get_variable $wrap_parser, Common::Variables::STRUCT_NOT_HIDDEN;
  my $conditional = generate_conditional $wrap_parser;

  $section_manager->append_string_to_conditional ($code_string, $conditional, 0);
  $section_manager->set_variable_for_conditional ($variable, $conditional);

  return $conditional;
}

sub wrap_proto ($$$$$$)
{
  my ($wrap_parser, $c_name, $result_type, $take_copy, $open, $const) = @_;
  my $section_manager = $wrap_parser->get_section_manager;
  my $result = undef;
  my $complete_cpp_type = get_complete_cpp_type $wrap_parser;

# TODO: make result type constant
  if ($result_type eq 'refptr')
  {
    $result = 'Glib::RefPtr< ' . $complete_cpp_type . ' >';
  }
  elsif ($result_type eq 'ref')
  {
    $result = $complete_cpp_type . '&';
  }
  elsif ($result_type eq 'ptr')
  {
    $result = $complete_cpp_type . '*';
  }
  elsif ($result_type eq 'plain')
  {
    $result = $complete_cpp_type;
  }
  else
  {
    die;
  }

  if ($const)
  {
    $result = 'const ' . $result;
  }

  my $params = ($const ? 'const ' : '') . $c_name . '* object';
  my $params_doc = ' * @param object The C instance.';

  if ($take_copy ne 'N/A')
  {
    $params_doc = nl ($params_doc) .
                  nl (' * @param take_copy @c false if the result should take ownership') .
                  ' * of the C instance. @c true if it should take a new copy or reference.';
    $params .= ', bool take_copy = ';
    if ($take_copy eq 'yes')
    {
      $params .= 'true';
    }
    elsif ($take_copy eq 'no')
    {
      $params .= 'false';
    }
    else
    {
      die;
    }
  }

  my $conditional = generate_conditional $wrap_parser;
  my $variable = get_variable $wrap_parser, Common::Variables::NO_WRAP_FUNCTION;
  my $code_string = '';

  if ($open)
  {
    $code_string .= nl ('namespace Glib') .
                    nl ('{') .
                    nl ();
  }

  $code_string .= nl ('/** A Glib::wrap() method for this object.') .
                  nl (' *') .
                  nl ($params_doc) .
                  nl (' * @result A C++ instance that wraps this C instance') .
                  nl (' *') .
                  nl (' * @relates ' . $complete_cpp_type) .
                  nl (' */') .
                  nl ($result . ' wrap(' . $params . ');') .
                  nl ();
  if ($open)
  {
    $code_string .= nl ('} //namespace Glib') .
                    nl ();
  }

  $section_manager->append_string_to_conditional ($code_string, $conditional, 0);
  $section_manager->set_variable_for_conditional ($variable, $conditional);

  return $conditional;
}

sub default_ctor_proto ($$)
{
  my ($wrap_parser, $cpp_name) = @_;
  my $section_manager = $wrap_parser->get_section_manager;
  my $variable = get_variable $wrap_parser, Common::Variables::CUSTOM_DEFAULT_CTOR;
  my $conditional = generate_conditional $wrap_parser;
  my $code_string = nl ('  ' . $cpp_name . '();');

  $section_manager->append_string_to_conditional ($code_string, $conditional, 0);
  $section_manager->set_variable_for_conditional ($variable, $conditional);

  return $conditional;
}

# wrap output of this function with nl();
sub copy_protos_str ($)
{
  my ($cpp_name) = @_;
  my $code_string = nl ('  ' . $cpp_name . '(const ' . $cpp_name . '& src);') .
                    '  ' . $cpp_name . '& operator=(const ' . $cpp_name . '& src);';

  return $code_string;
}

sub dtor_proto_str ($$)
{
  my ($cpp_name, $virtual_dtor) = @_;
  my $code_string = '  ' . ($virtual_dtor ? 'virtual ' : '') . '~' . $cpp_name . '();';

  return $code_string;
}

sub gobj_protos_str ($$$$)
{
  my ($c_name, $copy_proto, $reinterpret, $definitions) = @_;
  my $gobj = ($reinterpret ? 'reinterpret_cast< ' . $c_name . '* >(gobject_)' : 'gobject_');
  my $code_string = nl ('  /// Provides access to the underlying C instance.') .
                    nl ('  ' . $c_name . '* gobj()' . ($definitions ? ' { return ' . $gobj . '; }' : ';')) .
                    nl () .
                    nl ('  /// Provides access to the underlying C instance.') .
                    '  const ' . $c_name . '* gobj() const' . ($definitions ? ' { return ' . $gobj . '; }' : ';');

  if ($copy_proto ne 'no')
  {
    $code_string = nl ($code_string) .
                   nl () .
                   nl ('  /// Provides access to the underlying C instance. The caller is responsible for freeing it. Use when directly setting fields in structs.') .
                   '  ' . $c_name . '* gobj_copy()';
    if ($copy_proto eq 'const')
    {
      $code_string .= ' const';
    }
    elsif ($copy_proto ne 'yes')
    {
      die;
    }
    $code_string .= ';';
  }
  return $code_string;
}

sub _get_prefixed_name ($$$)
{
  my ($wrap_parser, $name, $name_type) = @_;
  my $prefixed_name = undef;

  given ($name_type)
  {
    when (Common::Constants::CLASS)
    {
      my $complete_type = get_complete_cpp_type $wrap_parser;

      $complete_type =~ s/::/_/g;
      $prefixed_name = join '_', $complete_type, $name;
    }
    when (Common::Constants::NAMESPACE)
    {
      my $full_namespace = get_full_namespace $wrap_parser;

      $full_namespace =~ s/::/_/g;
      $prefixed_name = join '_', $full_namespace, $name;
    }
    when (Common::Constants::FILE)
    {
      $prefixed_name = $name;
    }
    when (Common::Constants::FIRST_NAMESPACE)
    {
      my $first_namespace = get_first_namespace $wrap_parser;
      my $first_namespace_number = $wrap_parser->get_first_namespace_number;

      $prefixed_name = join '_', $first_namespace, $first_namespace_number, $name;
    }
    when (Common::Constants::FIRST_CLASS)
    {
      my $full_namespace = get_full_namespace $wrap_parser;
      my $first_class = get_first_class $wrap_parser;
      my $first_class_number = $wrap_parser->get_first_class_number;

      $full_namespace =~ s/::/_/g;

      $prefixed_name = join '_', $full_namespace, $first_class, $first_class_number, $name;
    }
    default
    {
      die;
    }
  }

  return $prefixed_name;
}

sub get_variable ($$)
{
  my ($wrap_parser, $variable) = @_;

  return _get_prefixed_name $wrap_parser, $variable->[0], $variable->[1];
}

sub get_section ($$)
{
  my ($wrap_parser, $section) = @_;

  return _get_prefixed_name $wrap_parser, $section->[0], $section->[1];
}

sub ifdef ($)
{
  my ($ifdef) = @_;

  if ($ifdef)
  {
    my $str = nl ('#ifdef ' . $ifdef) .
              nl ();

    return $str;
  }

  return '';
}

sub endif ($)
{
  my ($ifdef) = @_;

  if ($ifdef)
  {
    my $str = nl ('#endif // ' . $ifdef) .
              nl();

    return $str;
  }

  return '';
}

sub paramzipstr ($$)
{
  my ($array1, $array2) = @_;
  my $count = @{$array1};

# TODO: throw runtime error or internal error or whatever.
  die if $count != scalar(@{$array2});
  return join ', ', map { join ' ', $array1->[$_], $array2->[$_] } 0 .. $count - 1;
}

sub get_parent_from_object ($$)
{
  my ($wrap_parser, $object) = @_;
  my $section_manager = $wrap_parser->get_section_manager;
  my $variable = get_variable $wrap_parser, Common::Variables::IS_INTERFACE;
  my $code_string = '';

  if ($section_manager->get_variable ($variable))
  {
    $code_string = (nl 'g_type_interface_peek_parent( // Get the parent interface of the interface (The original underlying C inteface)') .
                   (nl '    g_type_interface_peek(G_OBJECT_GET_CLASS(', $object, '), CppObjectType::get_type()) // Get the interface.') .
                       '    )';
  }
  else
  {
    $code_string = 'g_type_class_peek_parent(G_OBJECT_GET_CLASS(' . $object . ')) // Get the parent class of the object class (The original underlying C class).';
  }

  return $code_string;
}

sub convzipstr ($$$$$)
{
  my ($wrap_parser, $from_types, $to_types, $transfers, $from_names) = @_;
  my $conversions_store = $wrap_parser->get_conversions_store;
  my $from_types_count = @{$from_types};
  my $to_types_count = @{$to_types};
  my $transfers_count = @{$transfers};
  my $from_names_count = @{$from_names};

# TODO: throw runtime error or internal error or whatever.
  die if $from_types_count != $to_types_count or $to_types_count != $transfers_count or $transfers_count != $from_names_count;
  return join ', ', map { $conversions_store->get_conversion ($from_types->[$_], $to_types->[$_], $transfers->[$_], $from_names->[$_]) } 0 .. $from_types_count - 1;
}

sub deprecate_start ($)
{
  my ($wrap_parser) = @_;
  my $mm_module = $wrap_parser->get_mm_module;

  return (nl '#ifdef ' . (uc $mm_module) . '_DISABLE_DEPRECATED') .
         (nl);
}

sub deprecate_end ($)
{
  my ($wrap_parser) = @_;
  my $mm_module = $wrap_parser->get_mm_module;

  return (nl '#endif // ' . (uc $mm_module) . '_DISABLE_DEPRECATED') .
         (nl);

}

1; # indicate proper module load.
