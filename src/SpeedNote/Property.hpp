// Copyright (C) Naostage - All Rights Reserved
// Unauthorized copying of this file, via any medium is strictly prohibited
// Proprietary and confidential

#ifndef __QMACROS_PROPERTY_HPP__
#define __QMACROS_PROPERTY_HPP__

// ──── INCLUDE ────

#include <QQmlEngine>

// ──── DECLARATION ────

#define _QMACROS_Q_PROPERTY(type, attribute, Attribute) \
protected: \
    Q_PROPERTY(type attribute READ attribute WRITE set##Attribute RESET reset##Attribute NOTIFY \
                   attribute##Changed) \
private:

#define _QMACROS_Q_PROPERTY_RO(type, attribute, Attribute) \
protected: \
    Q_PROPERTY(type attribute READ attribute NOTIFY attribute##Changed) \
private:

#define _QMACROS_Q_PROPERTY_CONST(type, attribute) \
protected: \
    Q_PROPERTY(type attribute READ attribute CONSTANT) \
private:

#define _QMACROS_PROPERTY_MEMBER(type, attribute, def) \
private: \
    type _##attribute = def; \
\
private:

#define _QMACROS_PROPERTY_MEMBER_NOD(type, attribute) \
private: \
    type _##attribute; \
\
private:

#define _QMACROS_PROPERTY_GETTER(type, attribute, override) \
public: \
    type attribute() const override \
    { \
        return _##attribute; \
    } \
\
private:

#define _QMACROS_PROPERTY_GETTER_ABSTRACT(type, attribute) \
public: \
    virtual type attribute() const = 0; \
\
private:

#define _QMACROS_PROPERTY_SETTER(type, attribute, Attribute, override) \
public: \
    virtual bool set##Attribute(const type &value) override \
    { \
        if (value != _##attribute) { \
            _##attribute = value; \
            Q_EMIT attribute##Changed(value); \
            return true; \
        } \
        return false; \
    } \
\
private:

#define _QMACROS_PROPERTY_VALIDATOR_SETTER(type, attribute, Attribute, override) \
public: \
    virtual bool set##Attribute(const type &value) override \
    { \
        if (value != _##attribute && is##Attribute##Valid(value)) { \
            _##attribute = value; \
            Q_EMIT attribute##Changed(value); \
            return true; \
        } \
        return false; \
    } \
\
private:

#define _QMACROS_ATTRIBUTE_SETTER(type, attribute, Attribute, override) \
public: \
    virtual bool set##Attribute(const type &value) override \
    { \
        if (value != _##attribute) { \
            _##attribute = value; \
            return true; \
        } \
        return false; \
    } \
\
private:

#define _QMACROS_PROPERTY_SETTER_ABSTRACT(type, Attribute) \
public: \
    virtual bool set##Attribute(const type &value) = 0; \
\
private:

#define _QMACROS_PROPERTY_RESET(type, Attribute, def) \
public: \
    void reset##Attribute() \
    { \
        set##Attribute(def); \
    } \
\
private:

#define _QMACROS_PROPERTY_RESET_RO(type, Attribute, def) \
private: \
    void reset##Attribute() \
    { \
        set##Attribute(def); \
    } \
\
private:

#define _QMACROS_PROPERTY_SIGNAL(type, attribute) \
Q_SIGNALS: \
    void attribute##Changed(type attribute); \
\
private:

#define _QMACROS_ABSTRACT_PROPERTY_SHARED(type, attribute, Attribute, def) \
    _QMACROS_PROPERTY_GETTER_ABSTRACT(type, attribute) \
    _QMACROS_PROPERTY_SETTER_ABSTRACT(type, Attribute) \
    _QMACROS_PROPERTY_RESET(type, Attribute, def) \
    _QMACROS_PROPERTY_SIGNAL(type, attribute)

#define QMACROS_ABSTRACT_PROPERTY_D(type, attribute, Attribute, def) \
    _QMACROS_Q_PROPERTY(type, attribute, Attribute) \
    _QMACROS_ABSTRACT_PROPERTY_SHARED(type, attribute, Attribute, def) \
private:

#define QMACROS_ABSTRACT_PROPERTY(type, attribute, Attribute) \
    QMACROS_ABSTRACT_PROPERTY_D(type, attribute, Attribute, {})

#define QMACROS_ABSTRACT_PROPERTY_RO_D(type, attribute, Attribute, def) \
    _QMACROS_Q_PROPERTY_RO(type, attribute, Attribute) \
    _QMACROS_ABSTRACT_PROPERTY_SHARED(type, attribute, Attribute, def) \
private:

#define QMACROS_ABSTRACT_PROPERTY_RO(type, attribute, Attribute) \
    QMACROS_ABSTRACT_PROPERTY_RO_D(type, attribute, Attribute, {})

#define _QMACROS_PROPERTY_SHARED(type, attribute, Attribute, def) \
    _QMACROS_PROPERTY_MEMBER(type, attribute, def) \
    _QMACROS_PROPERTY_GETTER(type, attribute, ) \
    _QMACROS_PROPERTY_SETTER(type, attribute, Attribute, ) \
    _QMACROS_PROPERTY_RESET(type, Attribute, def) \
    _QMACROS_PROPERTY_SIGNAL(type, attribute)

#define QMACROS_PROPERTY_D(type, attribute, Attribute, def) \
    _QMACROS_Q_PROPERTY(type, attribute, Attribute) \
    _QMACROS_PROPERTY_SHARED(type, attribute, Attribute, def) \
private:

#define QMACROS_PROPERTY(type, attribute, Attribute) \
    QMACROS_PROPERTY_D(type, attribute, Attribute, {})

#define QMACROS_PROPERTY_RO_D(type, attribute, Attribute, def) \
    _QMACROS_Q_PROPERTY_RO(type, attribute, Attribute) \
    _QMACROS_PROPERTY_SHARED(type, attribute, Attribute, def) \
private:

#define _QMACROS_PROPERTY_VALIDATOR_SHARED(type, attribute, Attribute, def) \
    _QMACROS_PROPERTY_MEMBER(type, attribute, def) \
    _QMACROS_PROPERTY_GETTER(type, attribute, ) \
    _QMACROS_PROPERTY_VALIDATOR_SETTER(type, attribute, Attribute, ) \
    _QMACROS_PROPERTY_RESET(type, Attribute, def) \
    _QMACROS_PROPERTY_SIGNAL(type, attribute)

#define QMACROS_PROPERTY_VALIDATOR_D(type, attribute, Attribute, def) \
    _QMACROS_Q_PROPERTY(type, attribute, Attribute) \
    _QMACROS_PROPERTY_VALIDATOR_SHARED(type, attribute, Attribute, def) \
private:

#define QMACROS_PROPERTY_VALIDATOR(type, attribute, Attribute) \
    QMACROS_PROPERTY_VALIDATOR_D(type, attribute, Attribute, {})
#define QMACROS_PROPERTY_VALIDATOR_MIN_MAX(type, attribute, Attribute, Min, Max) \
    QMACROS_PROPERTY_VALIDATOR_D(type, attribute, Attribute, {}) \
    static bool is##Attribute##Valid(const type &value) \
    { \
        return value >= Min && value <= Max; \
    }

#define QMACROS_PROPERTY_RO(type, attribute, Attribute) \
    QMACROS_PROPERTY_RO_D(type, attribute, Attribute, {})

#define _QMACROS_ATTRIBUTE_SHARED(type, attribute, Attribute, def) \
    _QMACROS_PROPERTY_MEMBER(type, attribute, def) \
    _QMACROS_PROPERTY_GETTER(type, attribute, ) \
    _QMACROS_ATTRIBUTE_SETTER(type, attribute, Attribute, )

#define QMACROS_PROPERTY_CONST_D(type, attribute, Attribute, def) \
    _QMACROS_Q_PROPERTY_CONST(type, attribute) \
    _QMACROS_ATTRIBUTE_SHARED(type, attribute, Attribute, def) \
private:

#define QMACROS_PROPERTY_CONST(type, attribute, Attribute) \
    QMACROS_PROPERTY_CONST_D(type, attribute, Attribute, {})

#define QMACROS_ATTRIBUTE_D(type, attribute, Attribute, def) \
    _QMACROS_ATTRIBUTE_SHARED(type, attribute, Attribute, def) \
private:

#define QMACROS_ATTRIBUTE(type, attribute, Attribute) \
    QMACROS_ATTRIBUTE_D(type, attribute, Attribute, {})

#define QMACROS_ABSTRACT_ATTRIBUTE(type, attribute, Attribute) \
    _QMACROS_PROPERTY_GETTER_ABSTRACT(type, attribute) \
    _QMACROS_PROPERTY_SETTER_ABSTRACT(type, Attribute)

#define _QMACROS_PTR_GETTER(type, attribute, override) \
public: \
    type *attribute() const override \
    { \
        return _##attribute; \
    }

#define _QMACROS_PTR_CONST_ONLY_GETTER(type, attribute, override) \
public: \
    const type *attribute() const override \
    { \
        return &_##attribute; \
    }

#define _QMACROS_PTR_CONST_GETTER(type, attribute, override) \
public: \
    _QMACROS_PTR_CONST_ONLY_GETTER(type, attribute, override) \
    type *attribute() override \
    { \
        return &_##attribute; \
    }

#define _QMACROS_PTR_SETTER_COMMON(type, attribute, Attribute, override) \
    virtual bool set##Attribute(type *value) override \
    { \
        if (value != _##attribute) { \
            _##attribute = value; \
            Q_EMIT attribute##Changed(); \
            return true; \
        } \
        return false; \
    }

#define _QMACROS_PTR_SETTER(type, attribute, Attribute, override) \
public: \
    _QMACROS_PTR_SETTER_COMMON(type, attribute, Attribute, override)

#define _QMACROS_PTR_SETTER_RO(type, attribute, Attribute, override) \
private: \
    _QMACROS_PTR_SETTER_COMMON(type, attribute, Attribute, override)

#define _QMACROS_PTR_SETTER_WITH_CONNECTION(type, attribute, Attribute, override) \
public: \
    virtual bool set##Attribute(type *value) override \
    { \
        if (value != _##attribute) { \
            disconnectFrom##Attribute(); \
            _##attribute = value; \
            connectTo##Attribute(); \
            Q_EMIT attribute##Changed(); \
            return true; \
        } \
        return false; \
    }

#define _QMACROS_ABSTRACT_PTR_GETTER(type, attribute) \
public: \
    virtual type *attribute() const = 0;

#define _QMACROS_ABSTRACT_PTR_SETTER(type, Attribute) \
public: \
    virtual bool set##Attribute(type *value) = 0;

#define _QMACROS_PTR_SIGNAL(type, attribute) \
Q_SIGNALS: \
    void attribute##Changed();

#define QMACROS_PTR(type, attribute, Attribute) \
    _QMACROS_Q_PROPERTY(type *, attribute, Attribute) \
    _QMACROS_PROPERTY_MEMBER(type *, attribute, nullptr) \
    _QMACROS_PTR_GETTER(type, attribute, ) \
    _QMACROS_PTR_SETTER(type, attribute, Attribute, ) \
    _QMACROS_PROPERTY_RESET(type, Attribute, nullptr) \
    _QMACROS_PTR_SIGNAL(type, attribute) \
private:

#define QMACROS_PTR_WITH_CONNECTION(type, attribute, Attribute) \
    _QMACROS_Q_PROPERTY(type *, attribute, Attribute) \
    _QMACROS_PROPERTY_MEMBER(type *, attribute, nullptr) \
    _QMACROS_PTR_GETTER(type, attribute, ) \
    _QMACROS_PTR_SETTER_WITH_CONNECTION(type, attribute, Attribute, ) \
    _QMACROS_PROPERTY_RESET(type, Attribute, nullptr) \
    _QMACROS_PTR_SIGNAL(type, attribute) \
private:

#define QMACROS_PTR_NO_SET(type, attribute, Attribute) \
    _QMACROS_Q_PROPERTY(type *, attribute, Attribute) \
    _QMACROS_PROPERTY_MEMBER(type *, attribute, nullptr) \
    _QMACROS_PTR_GETTER(type, attribute, ) \
    _QMACROS_PROPERTY_RESET(type, Attribute, nullptr) \
    _QMACROS_PTR_SIGNAL(type, attribute) \
private:

#define QMACROS_PTR_RO(type, attribute, Attribute) \
    _QMACROS_Q_PROPERTY_RO(QObject *, attribute, Attribute) \
    _QMACROS_PROPERTY_MEMBER(type *, attribute, nullptr) \
    _QMACROS_PTR_GETTER(type, attribute, ) \
    _QMACROS_PTR_SETTER_RO(type, attribute, Attribute, ) \
    _QMACROS_PROPERTY_RESET_RO(type, Attribute, nullptr) \
    _QMACROS_PTR_SIGNAL(type, attribute) \
private:

#define QMACROS_ABSTRACT_PTR(type, attribute, Attribute) \
    _QMACROS_Q_PROPERTY(type *, attribute, Attribute) \
    _QMACROS_ABSTRACT_PTR_GETTER(type, attribute) \
    _QMACROS_ABSTRACT_PTR_SETTER(type, Attribute) \
    _QMACROS_PROPERTY_RESET(type, Attribute, nullptr) \
    _QMACROS_PTR_SIGNAL(type, attribute) \
private:

#define QMACROS_ABSTRACT_PTR_RO(type, attribute, Attribute) \
    _QMACROS_Q_PROPERTY_RO(type *, attribute, Attribute) \
    _QMACROS_ABSTRACT_PTR_GETTER(type, attribute) \
    _QMACROS_ABSTRACT_PTR_SETTER(type, Attribute) \
    _QMACROS_PROPERTY_RESET(type, Attribute, nullptr) \
    _QMACROS_PTR_SIGNAL(type, attribute) \
private:

#define QMACROS_IMPL_PTR(type, attribute, Attribute) \
    _QMACROS_PROPERTY_MEMBER(type *, attribute, nullptr) \
    _QMACROS_PTR_GETTER(type, attribute, override) \
    _QMACROS_PTR_SETTER(type, attribute, Attribute, override) \
    _QMACROS_PROPERTY_RESET(type, Attribute, nullptr) \
    _QMACROS_PTR_SIGNAL(type, attribute) \
private:

#define QMACROS_PTR_CONST(type, attribute, Attribute) \
    _QMACROS_Q_PROPERTY_CONST(QObject *, attribute) \
    _QMACROS_PROPERTY_MEMBER(type *, attribute, nullptr) \
    _QMACROS_PTR_GETTER(type, attribute, ) \
private:

#define QMACROS_REGISTER_TO_QML(Type) \
public: \
    static void registerToQml(const char *name = #Type) \
    { \
        qmlRegisterType<Type>("QMACROS", 1, 0, name); \
    } \
\
private:

#define QMACROS_REGISTER_UNCREATABLE_TO_QML(Type) \
public: \
    static void registerToQml(const char *uri = "QMACROS", \
                              const int majorVersion = 1, \
                              const int minorVersion = 0, \
                              const char *name = #Type) \
    { \
        qmlRegisterUncreatableType<Type>(uri, majorVersion, minorVersion, name, ""); \
    } \
\
private:

#define QMACROS_SINGLETON_IMPL(Class, name, Name) \
public: \
    static Class &name() \
    { \
        static Class ret; \
        return ret; \
    } \
    static void registerSingleton(const char *uri = "QMACROS", \
                                  const int majorVersion = 1, \
                                  const int minorVersion = 0, \
                                  const char *n = #Class) \
    { \
        qmlRegisterSingletonInstance(uri, majorVersion, minorVersion, n, &name()); \
    } \
\
private:

#endif
